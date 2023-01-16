package team_project.buy_idea.controller.seller.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SellerProfileRequest {

    private String nickname;
    private String realName;
    private String phone;
    private String registrationNumber;
    private CompanyInfoRequest companyInfoRequest;
}
