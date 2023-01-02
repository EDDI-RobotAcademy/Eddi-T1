package team_project.buy_idea.repository.order;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.order.OrderInfo;

import java.util.List;


public interface OrderInfoRepository extends JpaRepository<OrderInfo, Long> {
    OrderInfo findTopByOrderByIdDesc();
}
