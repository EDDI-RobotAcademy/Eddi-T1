package team_project.buy_idea.product;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.request.ProductRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.repository.product.mapping.ProductImageMapping;
import team_project.buy_idea.repository.product.mapping.ProductMapping;
import team_project.buy_idea.service.product.ProductService;

import java.io.FileInputStream;

import java.util.ArrayList;
import java.util.List;


@SpringBootTest
@AutoConfigureMockMvc
public class ProductTestCase {

    @Autowired
    private ProductService productService;

    @Test
    public void productRegister() throws Exception {
        List<MultipartFile> fileList = new ArrayList<>() {};
        MockMultipartFile file1 = new MockMultipartFile(
                "image1", "kun1.jpg", "image/jpg", new FileInputStream("C:/Users/user/OneDrive/사진/KUN/kun1.jpg")
        );
        MockMultipartFile file2 = new MockMultipartFile(
                "image2", "kun2.jpg", "image/jpg", new FileInputStream("C:/Users/user/OneDrive/사진/KUN/kun2.jpg")
        );
        fileList.add(file1);
        fileList.add(file2);


        ProductRequest productRequest = new ProductRequest(
                "상품 타이틀", "상호명", "카테고리", "상세정보",
                "상품정보제공고시", 30000, 3000, 10);


        System.out.println("productRegister file :  " + fileList);
        System.out.println("productRegister request :  " + productRequest);

        productService.register(productRequest, fileList);
    }

    @Test
    void mainPageProductList() {
        // 핸드메이드 카테고리의 productNo이 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 17 이라고 가정

        // 핸드메이드 카테고리의 상품 리스트를 productNo 기준 내림차순으로 productSize의 수만큼 반환
        // 게시물을 처음 불러올 때 사용하는 로직. 카테고리와 불러올 상품 리스트 개수만 필요
        // productNo 17, 14, 13
        List<ProductMapping> products = productService.list("핸드메이드", 3);

        // 넘겨받은 productNo의 다음 낮은 수 기준 내림차순으로 productSize의 수만큼 핸드메이드 카테고리의 상품 리스트를 반환
        // 다음 게시물 리스트를 불러올 때 사용하는 로직. 마지막 게시물넘버와 카테고리, 불러올 상품 리스트 개수가 필요
        // productNo 13을 넘겨줬으므로 10, 9, 8, 7
        List<ProductMapping> products2 = productService.nextList(products.get(2).getProductNo(),"핸드메이드", 4);

        // 상품 게시물의 productNo을 받으면 해당 상품 이미지 리스트의 첫 번째 사진만 반환한다.
        ProductImageMapping productImage1 = productService.thumbnailImage(products.get(0).getProductNo());
        ProductImageMapping productImage2 = productService.thumbnailImage(products.get(1).getProductNo());
        ProductImageMapping productImage3 = productService.thumbnailImage(products.get(2).getProductNo());

        // products의 첫 번째 인덱스 No은 17, products2의 첫 번째 인덱스 No은 10
        System.out.println("productList : " + products.get(0).getProductNo() + ", " + products2.get(0).getProductNo());

        System.out.println("productThumbnailImage : " + productImage1.getImageId() + ", " + productImage2.getImageId() + ", " + productImage3.getImageId());
    }

}
