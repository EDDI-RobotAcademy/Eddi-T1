package team_project.buy_idea.controller.SellerInfo.request;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class SellerInfoRequestData {
    String seller;

    String city;
    String street;
    String addressDetail;
    String zipcode;
    String companyPhoneNumber;
    String companyRegisterNumber;

}
