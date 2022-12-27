package team_project.buy_idea.repository.product;

import org.springframework.data.jpa.repository.JpaRepository;
import team_project.buy_idea.entity.product.ProductInfo;

public interface ProductInfoRepository extends JpaRepository<ProductInfo, Long> {
}
