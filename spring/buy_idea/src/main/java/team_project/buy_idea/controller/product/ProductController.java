package team_project.buy_idea.controller.product;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.request.ProductRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.repository.product.mapping.ProductImageMapping;
import team_project.buy_idea.repository.product.mapping.ProductMapping;
import team_project.buy_idea.service.product.ProductService;
import team_project.buy_idea.service.product.response.SellerProductResponse;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/product")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping(value = "/register", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public void productRegister(
            @RequestPart(value = "files") List<MultipartFile> fileList,
            @RequestPart(value = "product") ProductRequest productRequest) {
        log.info("productRegister files :  " + fileList);
        log.info("productRegister product :  " + productRequest);

        productService.register(productRequest, fileList);

    }

    @GetMapping("/list")
    public List<ProductMapping> productList(
            @RequestParam("category") String category,
            @RequestParam("productSize") int productSize,
            @RequestParam("filter") String filter) {

        log.info("productList()");
        log.info("category : " + category);
        log.info("productsNum : " + productSize);
        log.info("filter: " + filter);

        return productService.list(category, productSize, filter);
    }

    @GetMapping("/list/next")
    public List<ProductMapping> nextProductList(
            @RequestParam("productNo") Long productNo,
            @RequestParam("category") String category,
            @RequestParam("productSize") int productSize,
            @RequestParam("filter") String filter,
            @RequestParam("productNoList") List<Long> productNoList) {

        log.info("nextProductList()");
        log.info("productNo : " + productNo);
        log.info("category : " + category);
        log.info("productSize : " + productSize);
        log.info("productNoList : " + productNoList);

        return productService.nextList(productNo, category, productSize, filter, productNoList);
    }

    @GetMapping("/image/thumbnail/{productNo}")
    public ProductImageMapping productThumbnailImage(@PathVariable("productNo") Long productNo) {

        log.info("productThumbnailImage()");
        log.info("productNo : " + productNo);

        return productService.thumbnailImage(productNo);
    }

    @GetMapping("/read/{productNo}")
    public Product productRead(@PathVariable("productNo") Long productNo) {
        log.info("productRead()");
        log.info("productNo : " + productNo);

        return productService.read(productNo);
    }

    @GetMapping("/images/{productNo}")
    public List<ProductImageMapping> productImageList(@PathVariable("productNo") Long productNo) {

        log.info("productImageList()");
        log.info("productNo : " + productNo);

        return productService.imageList(productNo);
    }

    @PutMapping("/modify/{productNo}")
    public String productModify(
            @PathVariable("productNo") Long productNo,
            @RequestPart(value = "files", required = false) List<MultipartFile> fileList,
            @RequestPart(value = "product") ProductRequest productRequest) {
        log.info("productModify files :  " + fileList);
        log.info("productModify product :  " + productRequest);

        productService.modify(productRequest, fileList, productNo);

        return "상품이 수정되었습니다.";
    }

    @DeleteMapping("/remove/{productNo}")
    public void productRemove (@PathVariable("productNo") Long productNo) {
        log.info("productRemove()");

        productService.remove(productNo);
    }


    @GetMapping("/search/{keyword}")
    public List<Product> productSearch (@PathVariable String keyword) {
        log.info("productSearch() : " + keyword);

        return productService.getFindSearchKeywordList(keyword);
    }
        

    @GetMapping("/allList/{nickname}")
    public List<Product> sellerProductAllList (@PathVariable("nickname") String nickname) {
        log.info("sellerProductAllList()" + nickname);

        return productService.sellerProductAllList(nickname);

    }

    @GetMapping("/seller/list")
    public List<SellerProductResponse> sellerProductList(@RequestParam(value = "seller") String seller,
                                                         @RequestParam(value = "category") String category,
                                                         @RequestParam(value = "productNo", required = false) Long productNo,
                                                         @RequestParam(value = "listSize") int listSize) {
        log.info("sellerProductList()");
        log.info("seller : " + seller);
        log.info("category : " + category);
        log.info("productNo : " + productNo);
        log.info("listSize : " + listSize);

        return productService.getProductsBySeller(seller, category, productNo, listSize);
    }


    //추가
}
