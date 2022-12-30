package team_project.buy_idea.repository.order.shopppingBucket;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucket;

import java.util.Optional;

@Repository
public interface ShoppingBucketRepository extends JpaRepository<ShoppingBucket, Long> {

    @Query("select sb from ShoppingBucket sb where sb.member.nickname =:nickname")
    Optional<ShoppingBucket> findByNickname(@Param("nickname") String nickname);
}
