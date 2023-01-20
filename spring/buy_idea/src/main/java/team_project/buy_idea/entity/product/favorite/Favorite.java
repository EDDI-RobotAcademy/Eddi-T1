package team_project.buy_idea.entity.product.favorite;

import lombok.*;
import team_project.buy_idea.entity.product.Product;

import javax.persistence.*;

@Data
@Entity
@ToString(exclude = {"product"})
@NoArgsConstructor
@AllArgsConstructor
public class Favorite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long favoriteNo;

    @Column(nullable = false)
    private String nickname;

    @Column(nullable = false)
    private boolean favoriteStatus = false;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    public boolean getFavoriteStatus() {
        return favoriteStatus;
    }
}
