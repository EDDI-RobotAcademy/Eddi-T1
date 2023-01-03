package team_project.buy_idea.controller.order;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.order.request.OrderRegisterRequest;
import team_project.buy_idea.service.order.OrderInfoService;

@Slf4j
@RestController
@RequestMapping("/order")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class OrderInfoController {

    @Autowired
    private OrderInfoService orderInfoService;

    @PostMapping("/register")
    public void orderRegister (@RequestBody OrderRegisterRequest request) {
        log.info("orderRegister()");
        log.info("OrderRegisterRequest request : " + request);

        orderInfoService.register(request.getAddressRequest(), request.getOrderInfoRequestList());
    }
}
