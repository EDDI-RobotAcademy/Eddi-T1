package team_project.buy_idea.entity.product.qna;

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
@ToString(exclude = "product")
@NoArgsConstructor
@AllArgsConstructor
public class QnA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long qnaNo;

    @Column(nullable = false)
    private String writer;

    @Column(nullable = false)
    private QuestionCategory questionCategory;

    @Column(nullable = false)
    private String questionTitle;

    @Column(nullable = false)
    private String questionContent;

    @Column(nullable = false)
    private String answer;

    @Column(nullable = false)
    private AnswerStatus answerStatus;

    @Column(nullable = false)
    private boolean openStatus;

    @CreationTimestamp
    private Date regDate;

    @UpdateTimestamp
    private Date updDate;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;
}
