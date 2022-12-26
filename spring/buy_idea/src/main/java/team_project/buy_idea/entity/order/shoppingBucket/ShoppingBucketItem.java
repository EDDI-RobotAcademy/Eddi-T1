package team_project.buy_idea.entity.order.shoppingBucket;

import lombok.*;
import team_project.buy_idea.entity.product.Product;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShoppingBucketItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long itemId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "shopping_bucket_id")
    private ShoppingBucket shoppingBucket;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id")
    private Product product;

    private int itemCount;


}
