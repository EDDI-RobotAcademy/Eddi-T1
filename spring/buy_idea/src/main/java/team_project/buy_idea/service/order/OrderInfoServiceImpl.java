package team_project.buy_idea.service.order;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.controller.order.request.OrderStatusModifyRequest;
import team_project.buy_idea.entity.order.Address;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.entity.order.OrderStatus;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.ProductInfo;
import team_project.buy_idea.repository.order.AddressRepository;
import team_project.buy_idea.repository.order.OrderInfoRepository;
import team_project.buy_idea.repository.product.ProductInfoRepository;
import team_project.buy_idea.repository.product.ProductRepository;

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


        Address address = new Address();
        List<OrderInfo> orderInfoList = new ArrayList<>();


        address.setOrderNo(setOrderNo);
        address.setRecipient(addressRequest.getRecipient());
        address.setPhone(addressRequest.getPhone());
        address.setZipcode(addressRequest.getZipcode());
        address.setCity(addressRequest.getCity());
        address.setStreet(addressRequest.getStreet());
        address.setAddressDetail(addressRequest.getAddressDetail());


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
            orderInfo.setAddress(address);
            orderInfoList.add(orderInfo);

            int stockCnt = productInfo.getStock();
            productInfo.setStock(stockCnt - request.getQuantity());
            productInfoRepository.save(productInfo);
        }

        addressRepository.save(address);
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
    public void myOrderStatusModify(OrderStatusModifyRequest orderStatusModifyRequest){
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
}