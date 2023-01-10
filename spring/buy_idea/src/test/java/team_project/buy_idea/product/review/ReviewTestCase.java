package team_project.buy_idea.product.review;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.mock.web.MockMultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewModifyRequest;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;
import team_project.buy_idea.entity.product.review.Review;
import team_project.buy_idea.repository.product.review.ReviewImageRepository;
import team_project.buy_idea.repository.product.review.ReviewRepository;
import team_project.buy_idea.repository.product.review.mapping.ReviewImageMapping;
import team_project.buy_idea.service.product.review.ReviewService;
import team_project.buy_idea.service.product.review.response.MyReviewResponse;

import java.io.FileInputStream;
import java.util.List;

@SpringBootTest
@AutoConfigureMockMvc
public class ReviewTestCase {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ReviewImageRepository reviewImageRepository;

    @Test
    void reviewRegisterTest() throws Exception {
        ReviewRegisterRequest request = new ReviewRegisterRequest(1L, "체크체크", 5, "좋습니다.");

        MockMultipartFile file = new MockMultipartFile(
                "image1", "review.jpg", "image/jpg",
                new FileInputStream("C:/Users/seonho/Desktop/review_image.jpg")
        );

        System.out.println("request : " + request);
        System.out.println("file : " + file);


        reviewService.register(request, file);

    }

    @Test
    void firstReviewListPageWithReviewImageTest() {
        Slice<Review> reviewSlice = reviewRepository.findReviewListOnSpecificProduct(1L, Pageable.ofSize(3));
        List<Review> reviews = reviewSlice.getContent();

        ReviewImageMapping reviewImageMapping = reviewImageRepository.findReviewImageByReviewNo(reviews.get(1).getReviewNo());

        System.out.println("firstReviewListPageTest : " + reviews);
        System.out.println("reviewImage id : " + reviewImageMapping.getReviewImageId());
        System.out.println("reviewImage editedName : " + reviewImageMapping.getEditedName());
    }

    @Test
    void nextReviewListPageWithReviewImageTest() {
        Slice<Review> firstReviewSlice = reviewRepository.findReviewListOnSpecificProduct(1L, Pageable.ofSize(1));
        List<Review> firstReviews = firstReviewSlice.getContent();

        Slice<Review> nextReviewSlice = reviewRepository.findNextReviewListOnSpecificProduct(1L, 3L, Pageable.ofSize(2));
        List<Review> nextReviews = nextReviewSlice.getContent();

        ReviewImageMapping reviewImageMapping = reviewImageRepository.findReviewImageByReviewNo(nextReviews.get(0).getReviewNo());

        System.out.println("firstReviewListPageTest : " + firstReviews);
        System.out.println("nextReviewListPageTest : " + nextReviews);
        System.out.println("reviewImage id : " + reviewImageMapping.getReviewImageId());
        System.out.println("reviewImage editedName : " + reviewImageMapping.getEditedName());
    }

    @Test
    void reviewCountTest() {
        Long reviewCount = reviewRepository.countReviewsOnSpecificProduct(1L);
        Double starRatingAverage = Double.parseDouble(String.format("%.1f", reviewRepository.findAverageStarRatingOnSpecificProduct(1L)));

        System.out.println(reviewCount);
        System.out.println(starRatingAverage);
    }

    @Test
    void reviewModifyTest() throws Exception {
        ReviewModifyRequest request = new ReviewModifyRequest(1L, 3, "상품 굳굳 짱짱 너무 좋다 또 살까 말까 고민고민하지마");
        MockMultipartFile file = new MockMultipartFile(
                "image1", "review111111.jpg", "image/jpg",
                new FileInputStream("C:/Users/seonho/Desktop/review_image.jpg")
        );
        reviewService.modify(request, file);
    }

    @Test
    void reviewDeleteTest() {
        reviewService.delete(29L);
    }

    @Test
    void myReviewListTest() {
        List<MyReviewResponse> myReviewList = reviewService.getMyReviewList("굳굳맨");

        System.out.println(myReviewList);
    }

    @Test
    void checkWriteReviewTest() {
        boolean check = reviewService.checkWriteReview("체크체크", 1L);

        System.out.println(check);
    }
}
