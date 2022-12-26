package team_project.buy_idea.repository.order.shopppingBucket;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucketItem;

import java.util.List;

@Repository
public interface ShoppingBucketProductRepository extends JpaRepository<ShoppingBucketItem, Long> {


}
