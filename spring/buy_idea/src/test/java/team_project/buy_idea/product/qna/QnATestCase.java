package team_project.buy_idea.product.qna;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.controller.product.qna.request.AnswerRegisterRequest;
import team_project.buy_idea.controller.product.qna.request.QuestionRegisterRequest;
import team_project.buy_idea.controller.product.qna.request.SellerQnaListRequest;
import team_project.buy_idea.service.product.qna.QnAService;
import team_project.buy_idea.service.product.qna.response.QnaHistoryResponse;

import java.util.List;


@SpringBootTest
@AutoConfigureMockMvc
public class QnATestCase {

    @Autowired
    private QnAService qnAService;

    /**
     * 문의 등록 Test
     */
    @Test
    void qnaRegisterTest() {
        QuestionRegisterRequest request = new QuestionRegisterRequest(
                50L, "ANNA", "상품 문의", "문의합니다.",
                "문의 내용", true);

        qnAService.register(request);
    }

    /**
     * 문의글 리스트 요청 Test
     */
    @Test
    void qnaHistoryList() {
        List<QnaHistoryResponse> qnaHistoryResponseList = qnAService.questionHistoryList("ANNA");
        System.out.println("qnaHistoryResponseList : " + qnaHistoryResponseList.get(0));
    }

    /**
     * 판매자 답변 상태에 따른 문의글 리스트 요청 Test
     */
    @Test
    void sellerQnaHistoryList() {
        SellerQnaListRequest sellerQnaListRequest = new SellerQnaListRequest("ANNAsSHOP", "답변 대기");
        List<QnaHistoryResponse> qnaHistoryResponseList = qnAService.qnaHistoryListByNicknameAndAnswerStatus(sellerQnaListRequest);
        System.out.println("qnaHistoryListByNicknameAndAnswerStatus : " + qnaHistoryResponseList.get(0));
    }

    /**
     * 판매자 답변 등록 Test
     */
    @Test
    void answerRegisterTest() {
        AnswerRegisterRequest request = new AnswerRegisterRequest(4L, "답변 작성했습니다아아아ㅏ ");

        qnAService.answerRegister(request);
    }
}
