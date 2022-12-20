package team_project.buy_idea.service.product;

import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.request.ProductRequest;

import java.util.List;


public interface ProductService {
    public void register(ProductRequest productRequest, List<MultipartFile> files);
}
