package team_project.buy_idea.controller.product.review;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;
import team_project.buy_idea.service.product.review.ReviewService;

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
}
