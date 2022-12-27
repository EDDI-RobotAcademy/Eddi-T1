package team_project.buy_idea.repository.product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.product.ProductInfo;

import javax.transaction.Transactional;

public interface ProductInfoRepository extends JpaRepository<ProductInfo, Long> {

    @Modifying
    @Transactional
    @Query("delete from ProductInfo pi where pi.product.productNo = :productNo")
    void deleteProductInfoByProductId(@Param("productNo") Long productNo);
}
