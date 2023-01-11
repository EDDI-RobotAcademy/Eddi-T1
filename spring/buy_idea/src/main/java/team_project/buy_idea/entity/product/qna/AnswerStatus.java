package team_project.buy_idea.entity.product.qna;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
public enum AnswerStatus {

    BEFORE_ANSWER("답변 대기"),
    ANSWER_COMPLETE("답변 완료");

    public final String answerStatus;

    AnswerStatus(String answerStatus){
        this.answerStatus = answerStatus;
    }
    public String answerStatus() {
        return answerStatus;
    }
}
