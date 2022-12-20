package team_project.buy_idea.product;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.request.ProductRequest;
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
}
