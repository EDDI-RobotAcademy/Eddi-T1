package team_project.buy_idea.controller.product.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ProductRequest {

    private String title;
    private String nickname;
    private String category;
    private String content;
    private String infoNotice;
    private int price;
    private int deliveryFee;
    private int stock;

}
