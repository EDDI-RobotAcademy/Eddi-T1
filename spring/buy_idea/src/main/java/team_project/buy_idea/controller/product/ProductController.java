package team_project.buy_idea.controller.product;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.request.ProductRequest;
import team_project.buy_idea.service.product.ProductService;

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
            @RequestPart(value = "file") List<MultipartFile> fileList,
            @RequestPart(value = "request") ProductRequest productRequest) {
        log.info("productRegister file :  " + fileList);
        log.info("productRegister request :  " + productRequest);

        productService.register(productRequest, fileList);

    }
}
