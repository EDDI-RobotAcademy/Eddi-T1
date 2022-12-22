package team_project.buy_idea.service.order;

import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.service.order.request.OrderInfoRequest;

import java.util.List;

public interface OrderInfoService {

    public void registerOrderInfo(OrderInfoRequest orderInfoRequest);

}
