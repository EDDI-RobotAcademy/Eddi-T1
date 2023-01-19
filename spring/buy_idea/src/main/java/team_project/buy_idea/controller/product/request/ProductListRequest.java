package team_project.buy_idea.controller.product.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ProductListRequest {
    String category;
    int productSize;
    String filter;
}
