package team_project.buy_idea.repository.product.review;

import org.springframework.data.jpa.repository.JpaRepository;
import team_project.buy_idea.entity.product.review.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

}
