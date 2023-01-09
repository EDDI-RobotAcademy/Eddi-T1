package team_project.buy_idea.entity.product.review;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import team_project.buy_idea.entity.product.Product;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@ToString(exclude = {"product", "reviewImage"})
@NoArgsConstructor
@AllArgsConstructor
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reviewNo;

    @Column(nullable = false)
    private String writer;

    @Column(nullable = false)
    private int starRating;

    @Column(nullable = false)
    private String content;

    @CreationTimestamp
    private Date regDate;

    @UpdateTimestamp
    private Date updDate;

    @JsonIgnore
    @OneToOne(mappedBy = "review",fetch = FetchType.LAZY)
    private ReviewImage reviewImage;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;
}
