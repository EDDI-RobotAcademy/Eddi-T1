package team_project.buy_idea.service.seller.response;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SellerInfoResponse {

    private String realName;
    private String phone;
    private String registrationNumber;
    private String city;
    private String street;
    private String addressDetail;
    private String zipcode;
}
