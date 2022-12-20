package team_project.buy_idea.service.product;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.request.ProductRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.ProductImage;
import team_project.buy_idea.entity.product.ProductInfo;
import team_project.buy_idea.repository.product.ProductImageRepository;
import team_project.buy_idea.repository.product.ProductRepository;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductImageRepository productImageRepository;

    /**
     * 상품 등록 ServiceImpl
     *
     * @param productRequest 상품 등록 정보
     * @param files          product image files
     */
    public void register(ProductRequest productRequest, List<MultipartFile> files) {
        Product product = new Product();
        ProductInfo productInfo = new ProductInfo();
        List<ProductImage> productImageList = new ArrayList<>();

        // Product & Product info Entity value add
        product.setTitle(productRequest.getTitle());
        product.setNickname(productRequest.getNickname());
        product.setPrice(productRequest.getPrice());
        productInfo.setCategory(productRequest.getCategory());
        productInfo.setContent(productRequest.getContent());
        productInfo.setInfoNotice(productRequest.getInfoNotice());
        productInfo.setStock(productRequest.getStock());
        productInfo.setDeliveryFee(productRequest.getDeliveryFee());
        product.setProductInfo(productInfo);


        for (MultipartFile multipartFile : files) {
            UUID uuid = UUID.randomUUID();
            String originalFileName = multipartFile.getOriginalFilename();
            String EditedName = uuid + originalFileName;
            String filePath = "C:\\Eddi-T1\\vue\\frontend\\src\\assets\\productImg\\";

            // Product Image Entity value add
            ProductImage productImage = new ProductImage();
            productImage.setOriginalName(originalFileName);
            productImage.setProduct(product);
            productImage.setEditedName(EditedName);
            productImage.setImagePath(filePath);
            productImageList.add(productImage);
            log.info(multipartFile.getOriginalFilename());

            try {
                FileOutputStream writer = new FileOutputStream(
                        filePath + EditedName
                );
                log.info("file upload success!");
                writer.write(multipartFile.getBytes());
                writer.close();

            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

        }
        productRepository.save(product);
        productImageRepository.saveAll(productImageList);

    }
}
