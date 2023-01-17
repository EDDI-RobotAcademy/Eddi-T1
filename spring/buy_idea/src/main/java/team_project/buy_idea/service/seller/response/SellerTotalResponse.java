package team_project.buy_idea.service.seller.response;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SellerTotalResponse {

    private Long totalProduct;
    private Long totalReview;
    private Long totalQnA;
    private Long totalOrder;
    private Long totalSales;
}