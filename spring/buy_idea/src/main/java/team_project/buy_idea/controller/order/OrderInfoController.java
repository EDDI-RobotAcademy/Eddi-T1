package team_project.buy_idea.controller.order;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.order.request.OrderRegisterRequest;
import team_project.buy_idea.controller.order.request.OrderStatusModifyRequest;
import team_project.buy_idea.controller.order.request.OrderStatusRequest;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.service.order.OrderInfoService;
import team_project.buy_idea.service.order.response.SellerProductOrderStatusResponse;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/order")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class OrderInfoController {

    @Autowired
    private OrderInfoService orderInfoService;

    @PostMapping("/register")
    public void orderRegister(@RequestBody OrderRegisterRequest request) {
        log.info("orderRegister()");
        log.info("OrderRegisterRequest request : " + request);

        orderInfoService.register(request.getAddressRequest(), request.getOrderInfoRequestList());
    }

    @PostMapping("/my-order-info-list/{nickname}")
    public List<OrderInfo> myOrderInfoList(@PathVariable("nickname") String nickname) {
        log.info("myOrderInfoList()");
        log.info("myOrderInfo buyer : " + nickname);

        return orderInfoService.myOrderInfoList(nickname);
    }

    @PostMapping("/status-modify/")
    public void orderStatusModify(@RequestBody OrderStatusModifyRequest request) {
        log.info("orderStatus()");
        log.info("orderStatus : " + request);

        orderInfoService.myOrderStatusModify(request);
    }

    @PostMapping("/seller-order-info-list")
    public List<OrderInfo> sellerOrderInfoList (@RequestBody OrderStatusRequest request) {
        log.info("SellerOrderInfoList()" + request);

        return orderInfoService.sellerOrderInfoList(request);

    }

    @PostMapping("/seller-order-status/{nickname}")
    public List<SellerProductOrderStatusResponse> sellerProductOrderStatusList
            (@PathVariable("nickname") String nickname) {
        return orderInfoService.getSellerProductOrderStatus(nickname);
    }

    @PostMapping("/seller-order-info-list-count/{seller}")
    public List<Long> sellerOrderInfoListCount (@PathVariable("seller") String seller) {
        log.info("SellerOrderInfoListCount()" + seller);

        return orderInfoService.sellerOrderInfoListCount(seller);
    }
}
