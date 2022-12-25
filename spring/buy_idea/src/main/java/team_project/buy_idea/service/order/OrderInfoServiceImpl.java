package team_project.buy_idea.service.order;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.entity.order.Address;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.repository.order.AddressRepository;
import team_project.buy_idea.repository.order.OrderInfoRepository;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;


@Slf4j
@Service
public class OrderInfoServiceImpl implements OrderInfoService {

    @Autowired
    OrderInfoRepository orderInfoRepository;

    @Autowired
    AddressRepository addressRepository;


    /**
     * 주문 등록 ServiceImpl
     * */
    @Override
    public void register(AddressRequest addressRequest, List<OrderInfoRequest> orderInfoRequestsList) {
        Address address = new Address();
        List<OrderInfo> orderInfoList = new ArrayList<>();


        address.setOrderNo(addressRequest.getOrderNo());
        address.setRecipient(addressRequest.getRecipient());
        address.setPhone(addressRequest.getPhone());
        address.setZipcode(addressRequest.getZipcode());
        address.setCity(addressRequest.getCity());
        address.setStreet(addressRequest.getStreet());
        address.setAddressDetail(addressRequest.getAddressDetail());


        String setOrderDate = DateTimeFormatter.ofPattern("yyyyMMddhhmm").format(LocalDateTime.now());

        for(OrderInfoRequest request : orderInfoRequestsList) {

            OrderInfo orderInfo = new OrderInfo();
            orderInfo.setOrderNo(request.getOrderNo());
            orderInfo.setOrderDate(setOrderDate);
            orderInfo.setBuyer(request.getBuyer());
            orderInfo.setSeller(request.getSeller());
            orderInfo.setTitle(request.getTitle());
            orderInfo.setQuantity(request.getQuantity());
            orderInfo.setPrice(request.getPrice());
            orderInfo.setOrderStatus(request.getOrderStatus());
            orderInfo.setAddress(address);
            orderInfoList.add(orderInfo);
        }

        addressRepository.save(address);
        orderInfoRepository.saveAll(orderInfoList);

    }
}
