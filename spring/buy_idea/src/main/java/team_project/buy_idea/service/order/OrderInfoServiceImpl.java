package team_project.buy_idea.service.order;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.entity.order.Address;
import team_project.buy_idea.entity.order.OrderInfo;
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
     * */
    @Override
    public void register(AddressRequest addressRequest, List<OrderInfoRequest> orderInfoRequestsList) {

        //주문번호 생성
        String currentDate = DateTimeFormatter.ofPattern("yyyyMMdd").format(LocalDateTime.now());
        //ex)YYYYMMDD000000001
        OrderInfo maybeOrderInfo = orderInfoRepository.findTopByOrderByIdDesc();

        String setOrderNo;

        if(maybeOrderInfo != null){
            String lastOrderNo = maybeOrderInfo.getOrderNo();
            String lastOrder = lastOrderNo.substring(lastOrderNo.length()-9);
            String lastDate = lastOrderNo.substring(0,8);
            //비교 세팅
            if ( lastDate.equals(currentDate) ) {
                int setLastOrder = Integer.parseInt(lastOrder) + 1;
                String tmp = String.format("%09d",setLastOrder);
                setOrderNo = lastDate + tmp;
            } else {
                setOrderNo = currentDate + "000000001";
            }
        }else{
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


        String setOrderDate = DateTimeFormatter.ofPattern("yyyyMMddhhmm").format(LocalDateTime.now());



        for(OrderInfoRequest request : orderInfoRequestsList) {

            Optional<Product> maybeProduct = productRepository.findById(request.getProductNo());
            Product product = maybeProduct.get();

            Optional<ProductInfo> maybeProductInfo = productInfoRepository.findById(request.getProductNo());
            ProductInfo productInfo = maybeProductInfo.get();

            OrderInfo orderInfo = new OrderInfo();
            orderInfo.setOrderNo(setOrderNo);
            orderInfo.setOrderDate(setOrderDate);
            orderInfo.setBuyer(request.getBuyer());
            orderInfo.setQuantity(request.getQuantity());
            orderInfo.setOrderStatus(request.getOrderStatus());
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
}
