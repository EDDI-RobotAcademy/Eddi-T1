package team_project.buy_idea.controller.order;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.service.order.OrderInfoService;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/order")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class OrderInfoController {

    @Autowired
    private OrderInfoService orderInfoService;

    @PostMapping("/register")
    public void orderRegister (
            @RequestPart(value = "orderInfo") List<OrderInfoRequest> orderInfoRequestList,
            @RequestPart(value = "address") AddressRequest addressRequest) {
        log.info("orderRegister orderInfo : " + orderInfoRequestList);
        log.info("orderRegister address : " + addressRequest);

        orderInfoService.register(addressRequest, orderInfoRequestList);
    }
}
