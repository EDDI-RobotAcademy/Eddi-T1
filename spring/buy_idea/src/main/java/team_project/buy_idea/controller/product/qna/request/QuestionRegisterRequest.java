package team_project.buy_idea.controller.product.qna.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class QuestionRegisterRequest {

    private Long productNo;
    private String writer;
    private String questionCategory;
    private String questionTitle;
    private String questionContent;
    private boolean openStatus;

}
