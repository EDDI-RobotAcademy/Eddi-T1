package team_project.buy_idea.entity.product;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;

@Data
@ToString(exclude = "product")
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class ProductImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long imageId;

    @Column(nullable = false)
    private String originalName;

    @Column(nullable = false)
    private String editedName;

    @Column(nullable = false)
    private String imagePathVue;

    @Column(nullable = false)
    private String imagePathFlutter;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id")
    private Product product;

}
