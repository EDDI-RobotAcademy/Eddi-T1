package team_project.buy_idea.repository.product;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.repository.product.mapping.ProductMapping;

public interface ProductRepository extends JpaRepository<Product, Long> {

    @Query("select p.productNo as productNo, p.title as title, p.nickname as nickname, p.price as price from Product p " +
            "where p.productInfo.category = :category " +
            "order by p.productNo desc ")
    Slice<ProductMapping> findFirstProductsByCategory(@Param("category") String category, Pageable pageable);

    @Query("select p.productNo as productNo, p.title as title, p.nickname as nickname, p.price as price from Product p " +
            "where p.productInfo.category = :category and p.productNo < :productNo " +
            "order by p.productNo desc ")
    Slice<ProductMapping> findNextProductsByCategory(@Param("productNo") Long productNo,
                                                     @Param("category") String category,
                                                     Pageable pageable);

}
