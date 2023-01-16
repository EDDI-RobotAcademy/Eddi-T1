package team_project.buy_idea.repository.product;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.repository.product.mapping.ProductMapping;

import java.util.List;
import java.util.Optional;


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


    @Query("select distinct p from Product p join fetch p.productImages where p.title like %:searchKeyword% order by p.productNo desc")
    List<Product> findAllProductByTitleContaining(String searchKeyword);


    @Query("select distinct p from Product p join fetch p.productImages join fetch p.productInfo where p.nickname = :nickname order by p.productNo desc")
    List<Product> findByNickname(@Param("nickname") String nickname);

    @Query("select p from Product p join fetch p.productImages where p.productNo = :productNo")
    Optional<Product> findById(@Param("productNo") Long productNo);

    @Query("select p from Product p join fetch p.productImages join fetch p.productInfo " +
            "where p.nickname = :seller and p.productInfo.category = :category " +
            "order by p.productNo desc ")
    Slice<Product> findProductsBySellerAndCategory(@Param("seller") String seller,
                                                   @Param("category") String category,
                                                   Pageable pageable);

    @Query("select p from Product p join fetch p.productImages join fetch p.productInfo " +
            "where p.nickname = :seller and p.productInfo.category = :category and p.productNo < :productNo " +
            "order by p.productNo desc ")
    Slice<Product> findNextProductsBySellerAndCategory(@Param("seller") String seller,
                                                       @Param("category") String category,
                                                       @Param("productNo") Long productNo,
                                                       Pageable pageable);
}
