package team_project.buy_idea.controller.product.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ProductNextListRequest {
    Long productNo;
    String category;
    int productSize;
    String filter;
    List<Long> productNoList;
}
