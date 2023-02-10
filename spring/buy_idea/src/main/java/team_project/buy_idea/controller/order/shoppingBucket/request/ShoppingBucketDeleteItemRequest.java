package team_project.buy_idea.controller.order.shoppingBucket.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ShoppingBucketDeleteItemRequest {

    private Long[] itemId;
    private String nickname;
}
