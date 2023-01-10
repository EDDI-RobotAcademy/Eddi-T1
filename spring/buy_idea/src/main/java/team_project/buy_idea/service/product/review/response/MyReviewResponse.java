package team_project.buy_idea.service.product.review.response;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class MyReviewResponse {

    Long reviewNo;
    String writer;
    int starRating;
    String content;
    Date regDate;
    Date updDate;
    Long productNo;
    String productTitle;
}
