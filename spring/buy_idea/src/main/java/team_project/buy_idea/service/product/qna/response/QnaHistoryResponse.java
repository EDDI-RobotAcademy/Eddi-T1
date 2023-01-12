package team_project.buy_idea.service.product.qna.response;

import lombok.*;
import team_project.buy_idea.entity.product.qna.AnswerStatus;
import team_project.buy_idea.entity.product.qna.QuestionCategory;

import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class QnaHistoryResponse {

    private Long productNo;
    private Long qnaNo;
    private String title;
    private String writer;
    private String nickname;
    private String questionCategory;
    private String questionTitle;
    private String questionContent;
    private String answer;
    private String answerStatus;
    private Date regDate;
    private Date updDate;
    private boolean openStatus;

}
