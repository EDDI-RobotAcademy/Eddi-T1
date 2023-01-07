package team_project.buy_idea.repository.order;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.order.OrderInfo;

import java.util.List;


public interface OrderInfoRepository extends JpaRepository<OrderInfo, Long> {
    OrderInfo findTopByOrderByIdDesc();

    @Query("select distinct oi from OrderInfo oi " +
            "join fetch oi.product p join fetch p.productImages " +
            "join fetch oi.address where oi.buyer = :nickname")
    List<OrderInfo> findMyOrderInfoListByNickname(@Param("nickname") String nickname);
}
