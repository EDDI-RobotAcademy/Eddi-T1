package team_project.buy_idea.product.review;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockMultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;
import team_project.buy_idea.service.product.review.ReviewService;

import java.io.FileInputStream;

@SpringBootTest
@AutoConfigureMockMvc
public class ReviewTestCase {

    @Autowired
    private ReviewService reviewService;

    @Test
    void reviewRegisterTest() throws Exception {
        ReviewRegisterRequest request = new ReviewRegisterRequest(1L, "굳굳맨", 5, "이 상품 너무 좋아요!");

        MockMultipartFile file = new MockMultipartFile(
                "image1", "review1", "image/jpg",
                new FileInputStream("C:/Users/seonho/Desktop/review_image.jpg")
        );

        System.out.println("request : " + request);
        System.out.println("file : " + file);

        reviewService.register(request, file);
    }
}
