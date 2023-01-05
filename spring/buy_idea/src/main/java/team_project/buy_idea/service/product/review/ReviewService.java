package team_project.buy_idea.service.product.review;

import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;

public interface ReviewService {

    void register(ReviewRegisterRequest request, MultipartFile file);
}
