package team_project.buy_idea.service.order.response;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SellerProductOrderStatusResponse {
    private String category;
    private String productTitle;
    private String productImage;
    private int paymentCompleteCount;
    private int deliveringCount;
    private int deliveredCount;
    private int cancelCount;
    private int exchangeCount;
    private int refundCount;
}
