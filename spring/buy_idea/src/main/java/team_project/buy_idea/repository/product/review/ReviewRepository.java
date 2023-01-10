package team_project.buy_idea.repository.product.review;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.product.review.Review;

import java.util.List;
import java.util.Optional;

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

    @Query("select count(r) from Review r join r.product p where p.productNo = :productNo")
    Long countReviewsOnSpecificProduct(@Param("productNo") Long productNo);

    @Query("select avg(r.starRating) from Review r join r.product p where p.productNo = :productNo")
    Double findAverageStarRatingOnSpecificProduct(@Param("productNo") Long productNo);

    @Query("select r from Review r join fetch r.product where r.writer = :writer order by r.reviewNo desc ")
    List<Review> findReviewsByWriter(@Param("writer") String writer);

    @Query("select r from Review r join fetch r.product p where r.writer = :writer and p.productNo = :productNo")
    Optional<Review> findReviewByWriterOnSpecificProduct(@Param("writer") String writer,
                                                         @Param("productNo") Long productNo);
}
