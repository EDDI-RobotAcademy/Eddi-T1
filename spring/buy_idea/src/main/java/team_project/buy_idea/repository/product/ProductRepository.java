package team_project.buy_idea.repository.product;

import org.springframework.data.jpa.repository.JpaRepository;
import team_project.buy_idea.entity.product.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {

}
