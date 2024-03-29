package team_project.buy_idea.repository.product.favorite;

import io.lettuce.core.dynamic.annotation.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import team_project.buy_idea.entity.product.favorite.Favorite;
import team_project.buy_idea.entity.product.qna.QnA;

import java.util.List;
import java.util.Optional;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {

    @Query("select f from Favorite f join fetch f.product p " +
            "where p.productNo = :productNo and f.nickname = :nickname")
    Optional<Favorite> findProductNoAndNickname(@Param("productNo") Long productNo,
                                                @Param("nickname") String nickname);

    @Query("select distinct f from Favorite f join fetch f.product p join fetch p.productInfo join fetch p.productImages " +
            "where f.nickname = :nickname")
    List<Favorite> findMyFavoriteListByNickname(String nickname);
}
