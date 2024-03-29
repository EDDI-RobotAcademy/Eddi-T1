package team_project.buy_idea.controller.product;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.request.ProductListRequest;
import team_project.buy_idea.controller.product.request.ProductNextListRequest;
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

    @PostMapping("/list")
    public List<ProductMapping> productList(@RequestBody ProductListRequest request) {

        log.info("productList()");
        log.info("category : " + request.getCategory());
        log.info("productSize : " + request.getProductSize());
        log.info("filter: " + request.getFilter());

        return productService.list(
                request.getCategory(),
                request.getProductSize(),
                request.getFilter());
    }

    @PostMapping("/list/next")
    public List<ProductMapping> nextProductList(@RequestBody ProductNextListRequest request) {

        log.info("nextProductList()");
        log.info("productNo : " + request.getProductNo());
        log.info("category : " + request.getCategory());
        log.info("productSize : " + request.getProductSize());
        log.info("filter : " + request.getFilter());
        log.info("productNoList : " + request.getProductNoList());

        return productService.nextList(
                request.getProductNo(),
                request.getCategory(),
                request.getProductSize(),
                request.getFilter(),
                request.getProductNoList());
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

    @GetMapping("getProduct/{productNo}")
    public Product getFavoriteProduct(@PathVariable("productNo") Long productNo){
        log.info("getFavoriteProduct" + productNo);

        return productService.getFavoriteProduct(productNo);
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
