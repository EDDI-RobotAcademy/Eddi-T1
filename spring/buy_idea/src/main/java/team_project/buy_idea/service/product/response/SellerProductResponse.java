package team_project.buy_idea.service.product.response;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SellerProductResponse {

    private Long productNo;
    private String title;
    private String seller;
    private int price;
    private int deliveryFee;
    private int stock;
    private Date regDate;
    private Date updDate;
    private String productImage;
    private Double starRatingAverage;
    private Long reviewCount;
}
