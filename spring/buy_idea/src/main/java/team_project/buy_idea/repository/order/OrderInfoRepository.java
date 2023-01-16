package team_project.buy_idea.repository.order;

import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.entity.order.OrderStatus;

import java.util.List;


public interface OrderInfoRepository extends JpaRepository<OrderInfo, Long> {
    OrderInfo findTopByOrderByIdDesc();

    @Query("select distinct oi from OrderInfo oi " +
            "join fetch oi.product p join fetch p.productImages " +
            "join fetch oi.address where oi.buyer = :nickname order by oi.id desc")
    List<OrderInfo> findMyOrderInfoListByNickname(@Param("nickname") String nickname);

    @Query("select distinct oi from OrderInfo oi " +
            "join fetch oi.product p join fetch p.productImages " +
            "join fetch oi.address where oi.product.nickname = :nickname and oi.orderStatus = :orderStatus order by oi.id desc")
    Slice<OrderInfo> findSellerOrderInfoListByNickname(@Param("nickname") String nickname,
                                                       @Param("orderStatus") OrderStatus orderStatus
    );

    @Query("select oi from OrderInfo oi join fetch oi.product p where p.productNo = :productNo")
    List<OrderInfo> findOrderStatusByProductNo(@Param("productNo") Long productNo);

    @Query("select count(oi) from OrderInfo oi " +
            "join oi.product p where oi.product.nickname = :nickname and oi.orderStatus = :orderStatus")
    Long countByProduct_NicknameAndOrderStatus(@Param("nickname") String nickname,
                                               @Param("orderStatus") OrderStatus orderStatus
    );
}
