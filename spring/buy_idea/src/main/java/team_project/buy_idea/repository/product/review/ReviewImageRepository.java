package team_project.buy_idea.repository.product.review;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.product.review.ReviewImage;
import team_project.buy_idea.repository.product.review.mapping.ReviewImageMapping;

import java.util.Optional;

public interface ReviewImageRepository extends JpaRepository<ReviewImage, Long> {

    @Query("select ri.reviewImageId as reviewImageId, ri.editedName as editedName from ReviewImage ri join ri.review r where r.reviewNo = :reviewNo")
    ReviewImageMapping findReviewImageByReviewNo(@Param("reviewNo") Long reviewNo);

    @Query("select ri from ReviewImage ri join ri.review r where r.reviewNo = :reviewNo")
    Optional<ReviewImage> findByReviewNo(@Param("reviewNo") Long reviewNo);
}
