package team_project.buy_idea.service.product.qna;

import team_project.buy_idea.controller.product.qna.request.AnswerRegisterRequest;
import team_project.buy_idea.controller.product.qna.request.QuestionRegisterRequest;
import team_project.buy_idea.controller.product.qna.request.SellerQnaListRequest;
import team_project.buy_idea.service.product.qna.response.QnaHistoryResponse;

import java.util.List;

public interface QnAService {
    void register(QuestionRegisterRequest request);
    List<QnaHistoryResponse> questionHistoryList(String writer);
    List<QnaHistoryResponse> questionHistoryListByproductNo(Long productNo);
    void deleteQna(Long qnaId);
    List<QnaHistoryResponse> qnaHistoryListByNicknameAndAnswerStatus(SellerQnaListRequest request);
    void answerRegister(AnswerRegisterRequest request);
    public void deleteAnswer(Long qnaNo);
}
