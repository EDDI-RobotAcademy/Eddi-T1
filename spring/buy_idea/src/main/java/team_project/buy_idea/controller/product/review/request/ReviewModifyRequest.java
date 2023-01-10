package team_project.buy_idea.controller.product.review.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ReviewModifyRequest {
    private Long reviewNo;
    private int starRating;
    private String content;
}
