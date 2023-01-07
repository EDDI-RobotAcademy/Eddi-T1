package team_project.buy_idea.product.review;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.mock.web.MockMultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;
import team_project.buy_idea.entity.product.review.Review;
import team_project.buy_idea.repository.product.review.ReviewImageRepository;
import team_project.buy_idea.repository.product.review.ReviewRepository;
import team_project.buy_idea.repository.product.review.mapping.ReviewImageMapping;
import team_project.buy_idea.service.product.review.ReviewService;

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
        ReviewRegisterRequest request = new ReviewRegisterRequest(1L, "굳굳맨", 3, "이 상품 너무 좋아요!");

        MockMultipartFile file = new MockMultipartFile(
                "image1", "review1", "image/jpg",
                new FileInputStream("C:/Users/seonho/Desktop/review_image.jpg")
        );

        System.out.println("request : " + request);
        System.out.println("file : " + file);

        for (int i = 0; i < 10; i++) {
            reviewService.register(request, file);
        }
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
}
