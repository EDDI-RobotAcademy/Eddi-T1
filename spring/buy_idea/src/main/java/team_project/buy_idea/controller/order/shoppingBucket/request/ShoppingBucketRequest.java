package team_project.buy_idea.controller.order.shoppingBucket.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ShoppingBucketRequest {

    private String memberToken;
    private Long productId;
    private int productAmountValue;

    public ShoppingBucketRequest toShoppingBucketRequest() {
        return new ShoppingBucketRequest(memberToken, productId, productAmountValue);
    }
}
