package team_project.buy_idea.service.order;

import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;

import java.util.List;

public interface OrderInfoService {
    public void register(AddressRequest addressRequest, List<OrderInfoRequest> orderInfoRequestsList);

}
