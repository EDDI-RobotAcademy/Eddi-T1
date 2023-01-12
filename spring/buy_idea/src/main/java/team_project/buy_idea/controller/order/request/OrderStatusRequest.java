package team_project.buy_idea.controller.order.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import team_project.buy_idea.entity.order.OrderStatus;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OrderStatusRequest {

    private String nickname;

    private String orderStatus;
}
