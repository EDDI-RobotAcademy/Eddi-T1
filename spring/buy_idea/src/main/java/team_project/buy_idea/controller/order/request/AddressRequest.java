package team_project.buy_idea.controller.order.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AddressRequest {

    private String recipient;
    private String phone;
    private String city;
    private String street;
    private String addressDetail;
    private String zipcode;

}
