package team_project.buy_idea.controller.product.qna;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.product.qna.request.QuestionRegisterRequest;
import team_project.buy_idea.controller.product.qna.request.SellerQnaListRequest;
import team_project.buy_idea.service.product.qna.QnAService;
import team_project.buy_idea.service.product.qna.response.QnaHistoryResponse;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/qna")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class QnAController {

    @Autowired
    private QnAService qnAService;

    /**
     * 문의 등록 Controller
     *
     * @param request ProductNo, writer, questionCategory,
     *                questionTitle, questionContent, openStatus
     */
    @PostMapping("/register")
    public void questionRegister(@RequestBody QuestionRegisterRequest request) {
        log.info("questionRegister()");
        log.info("request : " + request.toString());

        qnAService.register(request);
    }

    /**
     * 작성자의 문의 내역 List Controller
     * @param writer 문의 작성자(일반회원 닉네임)
     * @return 문의 내역 List
     */
    @PostMapping("/history-list/{writer}")
    public List<QnaHistoryResponse> myQuestionHistoryList(@PathVariable String writer) {
        log.info("myQuestionHistoryList() - writer");
        log.info("writer : " + writer);

        return qnAService.questionHistoryList(writer);
    }


    /**
     * 상품의 문의 내역  List Controller
     * @param productNo 상품 번호
     * @return 문의 내역 List
     */
    @PostMapping("/p-history-list/{productNo}")
    public List<QnaHistoryResponse> myQuestionHistoryList(@PathVariable Long productNo) {
        log.info("myQuestionHistoryList() - productNo");
        log.info("productNo : " + productNo);

        return qnAService.questionHistoryListByproductNo(productNo);
    }

    /**
     * 문의글 삭제 contoller
     * @param qnaNo
     */
    @DeleteMapping("/delete/{qnaNo}")
    public void deleteQna(@PathVariable("qnaNo") Long qnaNo) {
        log.info("deleteQna: " + qnaNo);
        qnAService.deleteQna(qnaNo);
    }

    /**
     * 판매자 닉네임과 답변 상태로 찾는 문의 내역 List Controller
     * @param request 판매자 닉네임(상호명), 답변 상태
     * @return 문의 내역 리스트
     */
    @PostMapping("/answer-status-list")
    public List<QnaHistoryResponse> qnaHistoryListByAnswerStatus(@RequestBody SellerQnaListRequest request) {
        log.info("qnaHistoryListByAnswerStatus()");
        log.info("request : " + request);

        return qnAService.qnaHistoryListByNicknameAndAnswerStatus(request);
    }
}
