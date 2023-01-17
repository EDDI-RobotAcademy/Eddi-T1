package team_project.buy_idea.controller.seller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.seller.request.SellerProfileRequest;
import team_project.buy_idea.service.seller.SellerService;
import team_project.buy_idea.service.seller.response.SellerInfoResponse;
import team_project.buy_idea.service.seller.response.SellerTotalResponse;

@Slf4j
@RestController
@RequestMapping("/seller")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class SellerController {

    @Autowired
    private SellerService sellerService;

    @PostMapping("/profile/register")
    public void receiveData (@RequestBody SellerProfileRequest sellerProfileRequest) {
        log.info("요청된 데이터 정보: " + sellerProfileRequest);

        sellerService.registerSellerProfile(sellerProfileRequest);
    }

    @PostMapping("/Info/{nickname}")
    public SellerInfoResponse sellerInfoForwarding(@PathVariable("nickname") String nickname) {
        log.info("sellerInfoForwarding" + nickname);

        return sellerService.sellerInfoResponseByNickname(nickname);
    }

    @PostMapping("/total-info/{seller}")
    public SellerTotalResponse sellerTotalInfo(@PathVariable("seller") String seller) {
        log.info("sellerTotalInfo()");
        log.info("seller : " + seller);

        return sellerService.getSellerTotalInfo(seller);
    }
}
