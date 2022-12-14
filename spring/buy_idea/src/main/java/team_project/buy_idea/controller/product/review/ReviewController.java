package team_project.buy_idea.controller.product.review;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewModifyRequest;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;
import team_project.buy_idea.entity.product.review.Review;
import team_project.buy_idea.repository.product.review.mapping.ReviewImageMapping;
import team_project.buy_idea.service.product.review.ReviewService;
import team_project.buy_idea.service.product.review.response.MyReviewResponse;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/review")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping(value = "/register", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public void reviewRegister(@RequestPart(value = "file") MultipartFile file,
                               @RequestPart(value = "review")ReviewRegisterRequest request) {
        log.info("reviewRegister()");
        log.info("file : " + file);
        log.info("request : " + request);

        reviewService.register(request, file);
    }

    @GetMapping("/list")
    public List<Review> reviewList(@RequestParam(value = "productNo") Long productNo,
                                   @RequestParam(value = "reviewSize") int reviewSize) {
        log.info("reviewList()");
        log.info("productNo : " + productNo + " reviewSize : " + reviewSize);

        return reviewService.getReviewList(productNo, reviewSize);
    }

    @GetMapping("/next-list")
    public List<Review> nextReviewList(@RequestParam(value = "productNo") Long productNo,
                                       @RequestParam(value = "reviewNo") Long reviewNo,
                                       @RequestParam(value = "reviewSize") int reviewSize) {
        log.info("nextReviewList()");
        log.info("productNo : " + productNo);
        log.info("reviewNo : " + reviewNo);
        log.info("reviewSize : " + reviewSize);

        return reviewService.getNextReviewList(productNo, reviewNo, reviewSize);
    }

    @GetMapping("/image/{reviewNo}")
    public ReviewImageMapping reviewImage(@PathVariable("reviewNo") Long reviewNo) {
        log.info("reviewImage()");
        log.info("reviewNo : " + reviewNo);

        return reviewService.getReviewImage(reviewNo);
    }

    @GetMapping("/count/{productNo}")
    public Long countReviews(@PathVariable("productNo") Long productNo) {
        log.info("countReviews()");
        log.info("productNo : " + productNo);

        return reviewService.getCountReviewsOnSpecificProduct(productNo);
    }

    @GetMapping("/star-rating/average/{productNo}")
    public Double averageOfStarRating(@PathVariable("productNo") Long productNo) {
        log.info("averageOfStarRating()");
        log.info("productNo : " + productNo);

        return reviewService.getAverageOfStarRatingOnSpecificProduct(productNo);
    }

    @PutMapping(value = "/modify", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public void reviewModify(@RequestPart(value = "review") ReviewModifyRequest request,
                             @RequestPart(value = "file") MultipartFile file) {
        log.info("reviewModify()");
        log.info("request : " + request);
        log.info("file : " + file);

        reviewService.modify(request, file);
    }

    @DeleteMapping("/delete/{reviewNo}")
    public void reviewDelete(@PathVariable("reviewNo") Long reviewNo) {
        log.info("reviewDelete()");
        log.info("reviewNo : " + reviewNo);

        reviewService.delete(reviewNo);
    }

    @GetMapping("/my-review/list/{writer}")
    public List<MyReviewResponse> myReviewList(@PathVariable("writer") String writer) {
        log.info("myReviewList()");
        log.info("writer : " + writer);

        return reviewService.getMyReviewList(writer);
    }

    @GetMapping("/check/write")
    public boolean checkWriteReview(@RequestParam(value = "writer") String writer,
                                    @RequestParam(value = "productNo") Long productNo) {
        log.info("checkWriteReview()");
        log.info("writer : " + writer);
        log.info("productNo : " + productNo);

        return reviewService.checkWriteReview(writer, productNo);
    }
}
