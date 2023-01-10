package team_project.buy_idea.service.product.review;

import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewModifyRequest;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;
import team_project.buy_idea.entity.product.review.Review;
import team_project.buy_idea.repository.product.review.mapping.ReviewImageMapping;
import team_project.buy_idea.service.product.review.response.MyReviewResponse;

import java.util.List;

public interface ReviewService {

    void register(ReviewRegisterRequest request, MultipartFile file);
    List<Review> getReviewList(Long productNo, int reviewSize);
    List<Review> getNextReviewList(Long productNo, Long lastReviewNo, int reviewSize);
    ReviewImageMapping getReviewImage(Long reviewNo);
    Long getCountReviewsOnSpecificProduct(Long productNo);
    Double getAverageOfStarRatingOnSpecificProduct(Long productNo);
    void modify(ReviewModifyRequest request, MultipartFile file);
    void delete(Long reviewNo);
    List<MyReviewResponse> getMyReviewList(String writer);
    boolean checkWriteReview(String writer, Long productNo);
}
