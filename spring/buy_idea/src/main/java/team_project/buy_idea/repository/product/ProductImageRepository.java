package team_project.buy_idea.repository.product;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.product.ProductImage;
import team_project.buy_idea.repository.product.mapping.ProductImageMapping;

import java.util.List;


public interface ProductImageRepository extends JpaRepository<ProductImage, Long> {

    @Query("select pi.imageId as imageId, pi.editedName as editedName from ProductImage pi join pi.product p where p.productNo = :productNo")
    List<ProductImageMapping> findProductImagesOnSpecificProduct(@Param("productNo") Long productNo);
}
