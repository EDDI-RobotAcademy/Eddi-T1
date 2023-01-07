package team_project.buy_idea.repository.product.review;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.product.review.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    @Query("select r from Review r join fetch r.product p " +
            "where p.productNo = :productNo " +
            "order by r.reviewNo desc ")
    Slice<Review> findReviewListOnSpecificProduct(@Param("productNo") Long productNo, Pageable pageable);

    @Query("select r from Review r join fetch r.product p " +
            "where p.productNo = :productNo and r.reviewNo < :reviewNo " +
            "order by r.reviewNo desc ")
    Slice<Review> findNextReviewListOnSpecificProduct(@Param("productNo") Long productNo,
                                                      @Param("reviewNo") Long reviewNo,
                                                      Pageable pageable);
}
