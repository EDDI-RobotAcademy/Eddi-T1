package team_project.buy_idea.service.product.review;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.review.Review;
import team_project.buy_idea.entity.product.review.ReviewImage;
import team_project.buy_idea.repository.product.ProductRepository;
import team_project.buy_idea.repository.product.review.ReviewImageRepository;
import team_project.buy_idea.repository.product.review.ReviewRepository;

import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ReviewImageRepository reviewImageRepository;

    @Autowired
    private ProductRepository productRepository;

    @Override
    public void register(ReviewRegisterRequest request, MultipartFile file) {
        Review review = new Review();
        ReviewImage reviewImage = new ReviewImage();

        Optional<Product> maybeProduct = productRepository.findById(request.getProductNo());
        Product product;
        if(maybeProduct.isPresent()) {
            product = maybeProduct.get();
        } else {
            throw new RuntimeException("등록되지 않은 상품입니다.");
        }

        review.setWriter(request.getWriter());
        review.setStarRating(request.getStarRating());
        review.setContent(request.getContent());
        review.setProduct(product);

        reviewRepository.save(review);

        UUID uuid = UUID.randomUUID();
        String originalFileName = file.getOriginalFilename();
        String editedName = uuid + originalFileName;
        String filePathVue = "C:\\Eddi-T1\\vue\\frontend\\src\\assets\\productImg\\";
        String filePathFlutter = "C:\\Eddi-T1\\flutter\\buy_idea\\assets\\product\\";

        reviewImage.setOriginalName(originalFileName);
        reviewImage.setEditedName(editedName);
        reviewImage.setImagePathVue(filePathVue);
        reviewImage.setImagePathFlutter(filePathFlutter);
        reviewImage.setReview(review);

        reviewImageRepository.save(reviewImage);
    }
}
