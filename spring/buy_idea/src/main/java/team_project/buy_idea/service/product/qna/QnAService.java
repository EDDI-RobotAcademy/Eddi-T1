package team_project.buy_idea.service.product.qna;

import team_project.buy_idea.controller.product.qna.request.QuestionRegisterRequest;
import team_project.buy_idea.service.product.qna.response.QnaHistoryResponse;

import java.util.List;

public interface QnAService {
    void register(QuestionRegisterRequest request);
    List<QnaHistoryResponse> questionHistoryList(String writer);
    List<QnaHistoryResponse> questionHistoryListByproductNo(Long productNo);
    void deleteQna(Long qnaId);
}
