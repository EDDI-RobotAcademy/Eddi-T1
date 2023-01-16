package team_project.buy_idea.order;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.controller.order.request.OrderStatusModifyRequest;
import team_project.buy_idea.controller.order.request.OrderStatusRequest;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.entity.order.OrderStatus;
import team_project.buy_idea.repository.order.OrderInfoRepository;
import team_project.buy_idea.service.order.OrderInfoService;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class OrderTestCase {

    @Autowired
    private OrderInfoService orderInfoService;

    @Autowired
    private OrderInfoRepository orderInfoRepository;

    @Test
    public void orderRegister() {

        List<OrderInfoRequest> orderInfoRequestList = new ArrayList<>();


        orderInfoRequestList.add(new OrderInfoRequest("재범1", 1L,2));
        orderInfoRequestList.add(new OrderInfoRequest("재범2",2L,1));
        orderInfoRequestList.add(new OrderInfoRequest("재범3",3L,4));
        orderInfoRequestList.add(new OrderInfoRequest("재범4",4L,2));
        orderInfoRequestList.add(new OrderInfoRequest("재범5",5L,5));
        orderInfoRequestList.add(new OrderInfoRequest("재범6",42L,1));
        orderInfoRequestList.add(new OrderInfoRequest("재범7",43L,3));


        AddressRequest addressRequest = new AddressRequest(
                 "쏘", "01012345678", "NewYork", "소호로", "303동", "07070");


        System.out.println("orderRegister orderInfo :  " + orderInfoRequestList);
        System.out.println("orderRegister request :  " + addressRequest);

        orderInfoService.register(addressRequest, orderInfoRequestList);
    }

    @Test
    public void genterateOrderNoTest() {
        System.out.println(orderInfoRepository.findTopByOrderByIdDesc());


        String currentDate = DateTimeFormatter.ofPattern("yyyyMMdd").format(LocalDateTime.now());

        //ex)YYYYMMDD000000001
        OrderInfo maybeOrderInfo = orderInfoRepository.findTopByOrderByIdDesc();
        String lastOrderNo = maybeOrderInfo.getOrderNo();
        String lastOrder = lastOrderNo.substring(lastOrderNo.length()-9);
        String lastDate = lastOrderNo.substring(0,8);

        String setOrderNo = null;

        if ( lastDate.equals(currentDate) ) {
            int setLastOrder = Integer.parseInt(lastOrder) + 1;
            String tmp = String.format("%09d",setLastOrder);
            setOrderNo = lastDate + tmp;
        }

        System.out.println(setOrderNo);
    }

    @Test
    void getMyOrderInfoList() {
        String nickname = "ANNA";
        List<OrderInfo> myOrderInfoList = orderInfoService.myOrderInfoList(nickname);

        System.out.println( "getMyOrderInfoList" + myOrderInfoList);
    }

    @Test
    void setOrderStatus() {
        OrderStatusModifyRequest orderStatusModifyRequest = new OrderStatusModifyRequest(2L, "배송 완료");
        orderInfoService.myOrderStatusModify(orderStatusModifyRequest);
    }

    @Test
    void getSellerOrderInfoList() {
        OrderStatusRequest orderStatusRequest = new OrderStatusRequest("쿤", "결제 완료");


        System.out.println(orderInfoService.SellerOrderInfoList(orderStatusRequest));

    }

    @Test
    void getSellerProductOrderStatus(){
        System.out.println(
                "getSellerProductOrderStatus()" + orderInfoService.getSellerProductOrderStatus("SunShine")
        );
    }

    @Test
    void getSellerOrderCount(){
        OrderStatusRequest orderStatusRequest = new OrderStatusRequest("쿤", "결제 완료");

        System.out.println(orderInfoService.SellerOrderInfoListCount(orderStatusRequest));
    }

    @Test
    void getSalesTest() {
        Long sales = orderInfoService.getSalesOfSeller("ANNAsSHOP");
        System.out.println(sales);
    }
}
