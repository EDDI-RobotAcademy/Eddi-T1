package team_project.buy_idea.controller.order.request;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OrderInfoRequest {

    private String buyer;
    private Long productNo;
    private int quantity;
    private String orderStatus;

}
