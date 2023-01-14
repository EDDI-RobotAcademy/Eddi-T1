package team_project.buy_idea.controller.product.qna.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AnswerRegisterRequest {

    private Long qnaNo;
    private String answer;

}
