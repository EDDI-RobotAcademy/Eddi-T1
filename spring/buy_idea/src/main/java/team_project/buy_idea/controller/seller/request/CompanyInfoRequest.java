package team_project.buy_idea.controller.seller.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class CompanyInfoRequest {

    private String city;
    private String street;
    private String addressDetail;
    private String zipcode;

}
