package team_project.buy_idea.repository.order.shopppingBucket;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucketItem;

import java.util.List;

@Repository
public interface ShoppingBucketProductRepository extends JpaRepository<ShoppingBucketItem, Long> {

    @Query("select distinct sbi from ShoppingBucketItem sbi join fetch sbi.shoppingBucket sb " +
            "join fetch sbi.product p join fetch p.productImages " +
            "join fetch sb.member m join fetch m.authentications " +
            "where m.nickname = :nickname")
    List<ShoppingBucketItem> findShoppingBucketItemListByNickname(@Param("nickname") String nickname);
}
