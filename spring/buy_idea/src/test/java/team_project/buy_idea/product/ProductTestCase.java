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
    void productListTest() {
        List<ProductMapping> products = productService.list("핸드메이드", 3, "낮은 가격순");

        List<Long> productNoList = new ArrayList<>();
        for (ProductMapping productMapping : products) {
            productNoList.add(productMapping.getProductNo());
        }
        List<ProductMapping> products2 = productService.nextList(products.get(2).getProductNo(),"핸드메이드", 4, "낮은 가격순", productNoList);

        for (int i = 0; i < products.size(); i++) {
            System.out.println("productNo : " + products.get(i).getProductNo() + " title : " + products.get(i).getTitle());
        }
        for (int i = 0; i < products2.size(); i++) {
            System.out.println("productNo : " + products2.get(i).getProductNo() + " title : " + products2.get(i).getTitle());
        }

        // 상품 게시물의 productNo을 받으면 해당 상품 이미지 리스트의 첫 번째 사진만 반환한다.
//        ProductImageMapping productImage1 = productService.thumbnailImage(products.get(0).getProductNo());
//        ProductImageMapping productImage2 = productService.thumbnailImage(products.get(1).getProductNo());
//        ProductImageMapping productImage3 = productService.thumbnailImage(products.get(2).getProductNo());

        // products의 첫 번째 인덱스 No은 17, products2의 첫 번째 인덱스 No은 10
        System.out.println("productList : " + products.get(0).getProductNo() + ", " + products2.get(0).getProductNo());

//        System.out.println("productThumbnailImage : " + productImage1.getImageId() + ", " + productImage2.getImageId() + ", " + productImage3.getImageId());
    }


    @Test
    void productImageList() {
        List<ProductImageMapping> productImages = productService.imageList(1L);

        System.out.println("productImageList : " + productImages.size());

        for (ProductImageMapping image : productImages) {
            System.out.println("image id : " + image.getImageId());
            System.out.println("image name : " + image.getEditedName());
        }
    }

    @Test
    void productRead() {
        Product product = productService.read(3L);

        System.out.println("product : " + product);
    }


    @Test
    public void productModify() throws Exception {
        List<MultipartFile> fileList = new ArrayList<>() {};
        MockMultipartFile file1 = new MockMultipartFile(
                "image1", "cookie3.jpg", "image/jpg", new FileInputStream("C:/Users/SAMSUNG/Desktop/사진/cookie3.jpg")
        );
        MockMultipartFile file2 = new MockMultipartFile(
                "image2", "cookie4.jpg", "image/jpg", new FileInputStream("C:/Users/SAMSUNG/Desktop/사진/cookie4.jpg")
        );
        fileList.add(file1);
        fileList.add(file2);


        ProductRequest productRequest = new ProductRequest(
                "제발돼라222", "rara", "노하우", "제발제발제발22222" +
                "행운의 포춘쿠키 선물set입니다",
                "으ㅇ아아ㅏㅇ222222", 40000, 1500, 12);


        System.out.println("productRegister file :  " + fileList);
        System.out.println("productRegister request :  " + productRequest);

        productService.modify(productRequest, fileList, 1L);

    }

    @Test
    public void productRemove() {
        productService.remove(1L);
    }

    @Test
    public void productSearch() {
        List<Product> searchList = productService.getFindSearchKeywordList("키링");
        System.out.println("searchList size : " + searchList.size());
        System.out.println("searchList : " + searchList);
    }

    @Test
    void sellerProductListTest() {
        System.out.println(productService.getProductsBySeller("쿤", "핸드메이드", null, 5));
    }
}
