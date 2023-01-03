package team_project.buy_idea.controller.order.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OrderRegisterRequest {

    private List<OrderInfoRequest> orderInfoRequestList;
    private AddressRequest addressRequest;
}
