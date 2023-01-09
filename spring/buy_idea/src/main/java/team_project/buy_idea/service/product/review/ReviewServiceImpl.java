package team_project.buy_idea.service.product.review;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.review.request.ReviewModifyRequest;
import team_project.buy_idea.controller.product.review.request.ReviewRegisterRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.review.Review;
import team_project.buy_idea.entity.product.review.ReviewImage;
import team_project.buy_idea.repository.product.ProductRepository;
import team_project.buy_idea.repository.product.review.ReviewImageRepository;
import team_project.buy_idea.repository.product.review.ReviewRepository;
import team_project.buy_idea.repository.product.review.mapping.ReviewImageMapping;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
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
        String filePathVue = "C:\\Eddi-T1\\vue\\frontend\\src\\assets\\reviewImg\\";
        String filePathFlutter = "C:\\Eddi-T1\\flutter\\buy_idea\\assets\\review\\";

        reviewImage.setOriginalName(originalFileName);
        reviewImage.setEditedName(editedName);
        reviewImage.setImagePathVue(filePathVue);
        reviewImage.setImagePathFlutter(filePathFlutter);
        reviewImage.setReview(review);

        try {
            FileOutputStream writerVue = new FileOutputStream(
                    filePathVue + editedName
            );
            FileOutputStream writerFlutter = new FileOutputStream(
                    filePathFlutter + editedName
            );
            writerVue.write(file.getBytes());
            writerFlutter.write(file.getBytes());
            writerVue.close();
            writerFlutter.close();
            log.info("file upload success");

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        reviewImageRepository.save(reviewImage);
    }

    @Override
    public List<Review> getReviewList(Long productNo, int reviewSize) {

        Slice<Review> reviewSlice = reviewRepository.findReviewListOnSpecificProduct(productNo, Pageable.ofSize(reviewSize));
        List<Review> reviewList = reviewSlice.getContent();

        return reviewList;
    }

    @Override
    public List<Review> getNextReviewList(Long productNo, Long lastReviewNo, int reviewSize) {

        Slice<Review> reviewSlice = reviewRepository.findNextReviewListOnSpecificProduct(productNo, lastReviewNo, Pageable.ofSize(reviewSize));
        List<Review> reviewList = reviewSlice.getContent();

        return reviewList;
    }

    @Override
    public ReviewImageMapping getReviewImage(Long reviewNo) {

        ReviewImageMapping reviewImage = reviewImageRepository.findReviewImageByReviewNo(reviewNo);

        return reviewImage;
    }

    @Override
    public Long getCountReviewsOnSpecificProduct(Long productNo) {

        Long reviewCount = reviewRepository.countReviewsOnSpecificProduct(productNo);

        return reviewCount;
    }

    @Override
    public Double getAverageOfStarRatingOnSpecificProduct(Long productNo) {

        Double starRatingAverage = Double.parseDouble(String.format("%.1f", reviewRepository.findAverageStarRatingOnSpecificProduct(productNo)));

        return starRatingAverage;
    }

    @Override
    public void modify(ReviewModifyRequest request, MultipartFile file) {
        Optional<Review> maybeReview = reviewRepository.findById(request.getReviewNo());
        Optional<ReviewImage> maybeReviewImage = reviewImageRepository.findByReviewNo(request.getReviewNo());
        Review review;
        ReviewImage reviewImage;
        if (maybeReview.isPresent() && maybeReviewImage.isPresent()) {
            review = maybeReview.get();
            reviewImage = maybeReviewImage.get();

            review.setStarRating(request.getStarRating());
            review.setContent(request.getContent());
            reviewRepository.save(review);

            String fileName = reviewImage.getEditedName();

            String vuePath = "C:\\Eddi-T1\\vue\\frontend\\src\\assets\\reviewImg\\";
            String flutterPath = "C:\\Eddi-T1\\flutter\\buy_idea\\assets\\review\\";

            File vueFile = new File(vuePath + fileName);
            File flutterFile = new File(flutterPath + fileName);

            if (vueFile.exists()) {
                vueFile.delete();
            } else {
                System.out.println("파일삭제실패!");
            }
            if (flutterFile.exists()) {
                flutterFile.delete();
            } else {
                System.out.println("파일삭제실패!");
            }

            UUID uuid = UUID.randomUUID();
            String originalFileName = file.getOriginalFilename();
            String editedName = uuid + originalFileName;

            try {
                FileOutputStream writerVue = new FileOutputStream(
                        vuePath + editedName
                );
                FileOutputStream writerFlutter = new FileOutputStream(
                        flutterPath + editedName
                );
                writerVue.write(file.getBytes());
                writerFlutter.write(file.getBytes());
                writerVue.close();
                writerFlutter.close();
                log.info("file upload success");

            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            reviewImage.setOriginalName(originalFileName);
            reviewImage.setEditedName(editedName);
            reviewImageRepository.save(reviewImage);

        } else {
            throw new RuntimeException("등록되지 않은 리뷰입니다.");
        }
    }
}
