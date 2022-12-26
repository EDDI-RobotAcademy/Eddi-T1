package team_project.buy_idea.entity.order.shoppingBucket;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import team_project.buy_idea.entity.member.Member;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShoppingBucket {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "member_id")
    private Member member;

    @JsonIgnore
    @Builder.Default
    @OneToMany(mappedBy = "shoppingBucket")
    private List<ShoppingBucketItem> shoppingBucketItems = new ArrayList<>();

    private int shoppingBucketTotalCnt;

    @DateTimeFormat(pattern = "yyyy-mm-dd")
    private LocalDate localDate;

    @PrePersist
    public void localDate(){
        this.localDate = LocalDate.now();
    }
}
