package team_project.buy_idea.controller.product.review.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ReviewRegisterRequest {
    private Long productNo;
    private String writer;
    private int starRating;
    private String content;
}
