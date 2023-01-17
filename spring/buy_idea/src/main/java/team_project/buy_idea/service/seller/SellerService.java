package team_project.buy_idea.service.seller;

import team_project.buy_idea.controller.seller.request.SellerProfileRequest;
import team_project.buy_idea.service.seller.response.SellerInfoResponse;
import team_project.buy_idea.service.seller.response.SellerTotalResponse;

public interface SellerService {

    void registerSellerProfile(SellerProfileRequest sellerProfileRequest);

    SellerInfoResponse sellerInfoResponseByNickname(String nickname);

    SellerTotalResponse getSellerTotalInfo(String seller);
}
