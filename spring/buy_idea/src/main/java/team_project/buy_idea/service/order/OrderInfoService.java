package team_project.buy_idea.service.order;

import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.controller.order.request.OrderStatusModifyRequest;
import team_project.buy_idea.controller.order.request.OrderStatusRequest;
import team_project.buy_idea.entity.order.OrderInfo;

import java.util.List;

public interface OrderInfoService {
    public void register(AddressRequest addressRequest, List<OrderInfoRequest> orderInfoRequestsList);

    List<OrderInfo> myOrderInfoList(String nickname);

    void myOrderStatusModify(OrderStatusModifyRequest orderStatusModifyRequest);

    public List<OrderInfo> SellerOrderInfoList(OrderStatusRequest request);
}