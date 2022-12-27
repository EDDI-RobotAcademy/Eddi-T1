package team_project.buy_idea.service.product;

import org.springframework.web.multipart.MultipartFile;
import team_project.buy_idea.controller.product.request.ProductRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.repository.product.mapping.ProductImageMapping;
import team_project.buy_idea.repository.product.mapping.ProductMapping;

import java.util.List;


public interface ProductService {
    public void register(ProductRequest productRequest, List<MultipartFile> files);
    public List<ProductMapping> list(String category, int productSize);
    public List<ProductMapping> nextList(Long lastProductNo, String category, int productSize);
    public ProductImageMapping thumbnailImage(Long productNo);
    public Product read(Long productNo);
    public List<ProductImageMapping> imageList(Long productNo);
    public void modify(ProductRequest productRequest, List<MultipartFile> files, Long productNo);
    public void remove(Long productNo);

}
