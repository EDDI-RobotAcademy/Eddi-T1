package team_project.buy_idea.order;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.service.order.OrderInfoService;

import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class OrderTestCase {

    @Autowired
    private OrderInfoService orderInfoService;

    @Test
    public void orderRegister() {

        List<OrderInfoRequest> orderInfoRequestList = new ArrayList<>();

        orderInfoRequestList.add(new OrderInfoRequest("20221219000000001","쏘쏘","anna","강쥐패딩",2,88000,"입금전"));
        orderInfoRequestList.add(new OrderInfoRequest("20221219000000001","쏘쏘","kun","강쥐 사료",1,43000,"입금완료"));
        orderInfoRequestList.add(new OrderInfoRequest("20221219000000001","쏘쏘","재범티비","핸드메이드 뜨개가방",4,120000,"배송중"));
        orderInfoRequestList.add(new OrderInfoRequest("20221219000000001","쏘쏘","jojo","핸드메이드 향초",4,230000,"배송완료"));


        AddressRequest addressRequest = new AddressRequest(
                "20221219000000001", "쏘", "01012345678", "NewYork", "소호로", "303동", "07070");


        System.out.println("orderRegister orderInfo :  " + orderInfoRequestList);
        System.out.println("orderRegister request :  " + addressRequest);

        orderInfoService.register(addressRequest, orderInfoRequestList);
    }
}
