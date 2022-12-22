package team_project.buy_idea.service.order;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.repository.order.OrderInfoRepository;
import team_project.buy_idea.service.order.request.OrderInfoRequest;

@Slf4j
@Service
public class OrderInfoServiceImpl implements OrderInfoService {

    @Autowired
    OrderInfoRepository repository;

    @Override
    public void registerOrderInfo(OrderInfoRequest orderInfoRequest) {

        final OrderInfo orderInfo = orderInfoRequest.toOrderInfo();

        repository.save(orderInfo);
    }
}
