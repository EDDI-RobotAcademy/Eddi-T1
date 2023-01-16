package team_project.buy_idea.service.order;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.controller.order.request.OrderStatusModifyRequest;
import team_project.buy_idea.controller.order.request.OrderStatusRequest;
import team_project.buy_idea.entity.order.DeliveryAddress;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.entity.order.OrderStatus;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.ProductInfo;
import team_project.buy_idea.repository.order.AddressRepository;
import team_project.buy_idea.repository.order.OrderInfoRepository;
import team_project.buy_idea.repository.product.ProductInfoRepository;
import team_project.buy_idea.repository.product.ProductRepository;
import team_project.buy_idea.service.order.response.SellerProductOrderStatusResponse;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Slf4j
@Service
public class OrderInfoServiceImpl implements OrderInfoService {

    @Autowired
    OrderInfoRepository orderInfoRepository;

    @Autowired
    AddressRepository addressRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductInfoRepository productInfoRepository;

    /**
     * 주문 등록 ServiceImpl
     */
    @Override
    public void register(AddressRequest addressRequest, List<OrderInfoRequest> orderInfoRequestsList) {

        //주문번호 생성
        String currentDate = DateTimeFormatter.ofPattern("yyyyMMdd").format(LocalDateTime.now());
        //ex)YYYYMMDD000000001
        OrderInfo maybeOrderInfo = orderInfoRepository.findTopByOrderByIdDesc();

        String setOrderNo;

        if (maybeOrderInfo != null) {
            String lastOrderNo = maybeOrderInfo.getOrderNo();
            String lastOrder = lastOrderNo.substring(lastOrderNo.length() - 9);
            String lastDate = lastOrderNo.substring(0, 8);
            //비교 세팅
            if (lastDate.equals(currentDate)) {
                int setLastOrder = Integer.parseInt(lastOrder) + 1;
                String tmp = String.format("%09d", setLastOrder);
                setOrderNo = lastDate + tmp;
            } else {
                setOrderNo = currentDate + "000000001";
            }
        } else {
            //최초 세팅
            setOrderNo = currentDate + "000000001";
        }


        DeliveryAddress deliveryAddress = new DeliveryAddress();
        List<OrderInfo> orderInfoList = new ArrayList<>();


        deliveryAddress.setOrderNo(setOrderNo);
        deliveryAddress.setRecipient(addressRequest.getRecipient());
        deliveryAddress.setPhone(addressRequest.getPhone());
        deliveryAddress.setZipcode(addressRequest.getZipcode());
        deliveryAddress.setCity(addressRequest.getCity());
        deliveryAddress.setStreet(addressRequest.getStreet());
        deliveryAddress.setAddressDetail(addressRequest.getAddressDetail());


        String setOrderDate = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm").format(LocalDateTime.now());


        for (OrderInfoRequest request : orderInfoRequestsList) {

            Optional<Product> maybeProduct = productRepository.findById(request.getProductNo());
            Product product = maybeProduct.get();

            Optional<ProductInfo> maybeProductInfo = productInfoRepository.findById(request.getProductNo());
            ProductInfo productInfo = maybeProductInfo.get();

            OrderInfo orderInfo = new OrderInfo();
            orderInfo.setOrderNo(setOrderNo);
            orderInfo.setOrderDate(setOrderDate);
            orderInfo.setBuyer(request.getBuyer());
            orderInfo.setQuantity(request.getQuantity());
            orderInfo.setOrderStatus(OrderStatus.PAYMENT_COMPLETE);
            orderInfo.setProduct(product);
            orderInfo.setDeliveryAddress(deliveryAddress);
            orderInfoList.add(orderInfo);

            int stockCnt = productInfo.getStock();
            productInfo.setStock(stockCnt - request.getQuantity());
            productInfoRepository.save(productInfo);
        }

        addressRepository.save(deliveryAddress);
        orderInfoRepository.saveAll(orderInfoList);

    }

    /**
     * 회원 주문 정보 list read
     *
     * @param nickname 일반회원 nickname
     * @return nickname 회원이 결제한 주문 정보 리스트 반환
     */
    @Override
    public List<OrderInfo> myOrderInfoList(String nickname) {
        return orderInfoRepository.findMyOrderInfoListByNickname(nickname);
    }

    /**
     * 주문 상태 변경 Service Impl
     * @param orderStatusModifyRequest 변경할 order info ID, 변경할 status 값
     */
    @Override
    public void myOrderStatusModify(OrderStatusModifyRequest orderStatusModifyRequest) {
        Long orderInfoId = orderStatusModifyRequest.getOrderInfoId();
        String orderStatus = orderStatusModifyRequest.getOrderStatus();
        Optional<OrderInfo> maybeOrderInfo = orderInfoRepository.findById(orderInfoId);

        OrderStatus status = switch (orderStatus) {
            case "결제 완료" -> OrderStatus.PAYMENT_COMPLETE;
            case "배송중" -> OrderStatus.DELIVERING;
            case "배송 완료" -> OrderStatus.DELIVERED;
            case "취소" -> OrderStatus.CANCEL;
            case "환불" -> OrderStatus.REFUND;
            case "교환" -> OrderStatus.EXCHANGE;
            default -> null;
        };

        OrderInfo orderInfo = maybeOrderInfo.get();
        orderInfo.setOrderStatus(status);
        orderInfoRepository.save(orderInfo);
    }

    @Override
    public List<OrderInfo> SellerOrderInfoList(OrderStatusRequest request) {
        log.info(request.getNickname());
        log.info(request.getOrderStatus());
        String sellerNickname = request.getNickname();
        String orderStatus = request.getOrderStatus();

        OrderStatus status = switch (orderStatus) {
            case "결제 완료" -> OrderStatus.PAYMENT_COMPLETE;
            case "배송중" -> OrderStatus.DELIVERING;
            case "배송 완료" -> OrderStatus.DELIVERED;
            case "취소" -> OrderStatus.CANCEL;
            case "환불" -> OrderStatus.REFUND;
            case "교환" -> OrderStatus.EXCHANGE;
            default -> null;
        };

        Slice<OrderInfo> orderSlice = orderInfoRepository.findSellerOrderInfoListByNickname(sellerNickname, status);
        List<OrderInfo> sellerOrderInfoList = orderSlice.getContent();

        return sellerOrderInfoList;
    }


    /**
     * 판매자가 등록한 상품의 주문 상태 현황을 반환하는 Service Impl
     *
     * @param nickname 판매자 상호명(닉네임)
     * @return 상품 카테고리, 타이틀, 해당 상품에 대한 주문상태 개수
     */
    @Override
    public List<SellerProductOrderStatusResponse> getSellerProductOrderStatus(String nickname) {
        List<Product> productList = productRepository.findByNickname(nickname);
        List<SellerProductOrderStatusResponse> sellerResponseList = new ArrayList<>();
        List<OrderInfo> orderStatusList;
        for (int i = 0; i < productList.size(); i++) {
            int paymentCompleteCount = 0;
            int deliveringCount = 0;
            int deliveredCount = 0;
            int cancelCount = 0;
            int exchangeCount = 0;
            int refundCount = 0;

            orderStatusList = orderInfoRepository.findOrderStatusByProductNo(productList.get(i).getProductNo());
            for (int j = 0; j < orderStatusList.size(); j++) {
                OrderStatus statusValue = orderStatusList.get(j).getOrderStatus();
                switch (statusValue) {
                    case PAYMENT_COMPLETE -> paymentCompleteCount++;
                    case DELIVERING -> deliveringCount++;
                    case DELIVERED -> deliveredCount++;
                    case CANCEL -> cancelCount++;
                    case EXCHANGE -> exchangeCount++;
                    case REFUND -> refundCount++;
                }
            }

            if (paymentCompleteCount + deliveringCount + deliveredCount + cancelCount + exchangeCount + refundCount == 0) {
                continue;
            }

            sellerResponseList.add(
                    new SellerProductOrderStatusResponse(
                            productList.get(i).getProductInfo().getCategory(),
                            productList.get(i).getTitle(),
                            productList.get(i).getProductImages().get(0).getEditedName(),
                            paymentCompleteCount,
                            deliveringCount,
                            deliveredCount,
                            cancelCount,
                            exchangeCount,
                            refundCount
                    )
            );
        }
        return sellerResponseList;
    }

    @Override
    public Long SellerOrderInfoListCount(OrderStatusRequest request){
        log.info(request.getNickname());
        log.info(request.getOrderStatus());
        String sellerNickname = request.getNickname();
        String orderStatus = request.getOrderStatus();

        OrderStatus status = switch (orderStatus) {
            case "결제 완료" -> OrderStatus.PAYMENT_COMPLETE;
            case "배송중" -> OrderStatus.DELIVERING;
            case "배송 완료" -> OrderStatus.DELIVERED;
            case "취소" -> OrderStatus.CANCEL;
            case "환불" -> OrderStatus.REFUND;
            case "교환" -> OrderStatus.EXCHANGE;
            default -> null;
        };

        Long OrderInfoCount = orderInfoRepository.countByProduct_NicknameAndOrderStatus(sellerNickname, status);

        return OrderInfoCount;
    }
}