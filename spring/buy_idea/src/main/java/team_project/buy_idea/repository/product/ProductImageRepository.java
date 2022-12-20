package team_project.buy_idea.repository.product;

import org.springframework.data.jpa.repository.JpaRepository;
import team_project.buy_idea.entity.product.ProductImage;


public interface ProductImageRepository extends JpaRepository<ProductImage, Long> {
}
