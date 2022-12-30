package team_project.buy_idea.controller.SellerInfo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.SellerInfo.request.SellerInfoRequestData;

@Slf4j
@RestController
@RequestMapping("/seller-info")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class SellerInfoReceiveController {

    @PostMapping("/register")
    public void receiveData (@RequestBody SellerInfoRequestData vueRequestTestData) {
        log.info("요청된 데이터 정보: " + vueRequestTestData);
    }
}
