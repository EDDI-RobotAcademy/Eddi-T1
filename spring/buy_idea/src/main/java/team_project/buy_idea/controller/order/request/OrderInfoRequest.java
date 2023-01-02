package team_project.buy_idea.controller.order.request;

import lombok.*;
import team_project.buy_idea.entity.order.Address;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OrderInfoRequest {

    private String buyer;
    private String seller;
    private String title;
    private int quantity;
    private int price;
    private String orderStatus;

}
