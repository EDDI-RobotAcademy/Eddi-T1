package team_project.buy_idea.seller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.controller.seller.request.CompanyInfoRequest;
import team_project.buy_idea.controller.seller.request.SellerProfileRequest;
import team_project.buy_idea.service.seller.SellerService;
import team_project.buy_idea.service.seller.response.SellerTotalResponse;

@SpringBootTest
public class SellerTestCase {

    @Autowired
    private SellerService sellerService;

    @Test
    void registerSellerInfo(){
        CompanyInfoRequest companyInfoRequest = new CompanyInfoRequest("city", "street", "addressDetail", "zipcode");
        SellerProfileRequest sellerProfileRequest = new SellerProfileRequest("gggg","진짜이름", "010-0000-0000", "012-34-4567", companyInfoRequest);

        sellerService.registerSellerProfile(sellerProfileRequest);
    }

    @Test
    void findSellerInfo(){
        String nickname = "gggg";

        System.out.println(sellerService.sellerInfoResponseByNickname(nickname));
    }

    @Test
    void getSellerTotalInfoTest() {
        SellerTotalResponse response = sellerService.getSellerTotalInfo("ANNAsSHOP");

        System.out.println(response);
    }
}
