package team_project.buy_idea.controller.order.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OrderStatusModifyRequest {
    Long orderInfoId;
    String orderStatus;
}
