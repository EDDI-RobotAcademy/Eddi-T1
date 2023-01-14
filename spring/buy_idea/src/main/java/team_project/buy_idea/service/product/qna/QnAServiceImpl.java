package team_project.buy_idea.service.product.qna;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.product.qna.request.AnswerRegisterRequest;
import team_project.buy_idea.controller.product.qna.request.QuestionRegisterRequest;
import team_project.buy_idea.controller.product.qna.request.SellerQnaListRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.qna.AnswerStatus;
import team_project.buy_idea.entity.product.qna.QnA;
import team_project.buy_idea.entity.product.qna.QuestionCategory;
import team_project.buy_idea.repository.product.ProductRepository;
import team_project.buy_idea.repository.product.qna.QnARepository;
import team_project.buy_idea.service.product.qna.response.QnaHistoryResponse;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Slf4j
@Service
public class QnAServiceImpl implements QnAService {

    @Autowired
    private QnARepository qnARepository;

    @Autowired
    private ProductRepository productRepository;

    /**
     * 문의 등록 ServiceImpl
     *
     * @param request ProductNo, writer, questionCategory,
     *                questionTitle, questionContent, openStatus
     */
    public void register(QuestionRegisterRequest request) {
        QnA qnA = new QnA();

        Optional<Product> maybeProduct = productRepository.findById(request.getProductNo());

        Product product;
        if (maybeProduct.isPresent()) {
            product = maybeProduct.get();
        } else {
            throw new RuntimeException("등록되지 않은 상품입니다.");
        }

        qnA.setWriter(request.getWriter());
        qnA.setProduct(product);
        qnA.setQuestionCategory(questionCategoryStringMapping(request.getQuestionCategory()));
        qnA.setQuestionTitle(request.getQuestionTitle());
        qnA.setQuestionContent(request.getQuestionContent());
        qnA.setAnswerStatus(AnswerStatus.BEFORE_ANSWER);
        qnA.setAnswer("");
        qnA.setOpenStatus(request.isOpenStatus());

        qnARepository.save(qnA);
    }

    /**
     * 작성자로 찾는 문의 내역 List
     *
     * @param writer 작성자(일반회원 닉네임)
     * @return 문의 내역 리스트
     */
    public List<QnaHistoryResponse> questionHistoryList(String writer) {
        List<QnaHistoryResponse> qnaHistoryResponseList = new ArrayList<>();
        List<QnA> qnAList = qnARepository.findQnaHistoryByWriter(writer);

        return getQnaHistoryResponses(qnaHistoryResponseList, qnAList);
    }

    /**
     * 상품 번호로 찾는 문의 내역 List
     *
     * @param productNo 상품 번호
     * @return 문의 내역 리스트
     */
    public List<QnaHistoryResponse> questionHistoryListByproductNo(Long productNo) {
        List<QnaHistoryResponse> qnaHistoryResponseList = new ArrayList<>();
        List<QnA> qnAList = qnARepository.findQnaHistoryByProductNo(productNo);

        return getQnaHistoryResponses(qnaHistoryResponseList, qnAList);
    }

    /**
     * 문의 내역 리스트를 QnaHistoryResponse에 저장하는 시스템
     *
     * @param qnaHistoryResponseList 담을 QnaHistoryResponse 리스트
     * @param qnAList                찾은 리스트
     * @return response 형태에 저장한 리스트
     */
    private List<QnaHistoryResponse> getQnaHistoryResponses(
            List<QnaHistoryResponse> qnaHistoryResponseList, List<QnA> qnAList) {
        for (int i = 0; i < qnAList.size(); i++) {
            qnaHistoryResponseList.add(
                    new QnaHistoryResponse(
                            qnAList.get(i).getProduct().getProductNo(),
                            qnAList.get(i).getQnaNo(),
                            qnAList.get(i).getProduct().getTitle(),
                            qnAList.get(i).getWriter(),
                            qnAList.get(i).getProduct().getNickname(),
                            qnAList.get(i).getQuestionCategory().questionCategory(),
                            qnAList.get(i).getQuestionTitle(),
                            qnAList.get(i).getQuestionContent(),
                            qnAList.get(i).getAnswer(),
                            qnAList.get(i).getAnswerStatus().answerStatus(),
                            qnAList.get(i).getRegDate(),
                            qnAList.get(i).getUpdDate(),
                            qnAList.get(i).isOpenStatus()
                    ));
        }
        return qnaHistoryResponseList;
    }

    /**
     * 문의글 삭제 service
     *
     * @param qnaNo 문의글 번호
     */
    @Override
    public void deleteQna(Long qnaNo) {
        qnARepository.deleteById(qnaNo);
    }


    /**
     * 판매자와 답변 상태로 찾는 문의 내역 List
     * @param request 판매자 닉네임(상호명), 답변 상태
     * @return 문의 내역 리스트
     */
    public List<QnaHistoryResponse> qnaHistoryListByNicknameAndAnswerStatus(SellerQnaListRequest request) {
        List<QnaHistoryResponse> qnaHistoryResponseList = new ArrayList<>();
        String nickname = request.getNickname();
        AnswerStatus answerStatus = answerStatusStringMapping(request.getAnswerStatus());
        List<QnA> qnAList = qnARepository.findQnaHistoryByNicknameAndAnswerStatus(nickname, answerStatus);

        return getQnaHistoryResponses(qnaHistoryResponseList, qnAList);
    }


    /**
     * 판매자 답변 등록 service Impl
     * @param request 문의글 번호, answer(답변 본문)
     */
    @Override
    public void answerRegister(AnswerRegisterRequest request) {
        Optional<QnA> maybeQnA = qnARepository.findById(request.getQnaNo());

        QnA qnA = maybeQnA.get();

        qnA.setAnswer(request.getAnswer());
        qnA.setAnswerStatus(AnswerStatus.ANSWER_COMPLETE);

        qnARepository.save(qnA);

    }

    /**
     * 판매자 답변 삭제 Service Impl
     * @param qnaNo 문의글 번호
     */
    @Override
    public void deleteAnswer(Long qnaNo) {
        Optional<QnA> maybeQnA = qnARepository.findById(qnaNo);

        QnA qna = maybeQnA.get();

        qna.setAnswerStatus(AnswerStatus.BEFORE_ANSWER);
        qna.setAnswer("");

        qnARepository.save(qna);
    }


    /**
     * 문의 카테고리 String -> enum 변환 메서드
     *
     * @param categoryName String 문의 카테고리
     * @return 문의카테고리 enum
     */
    public QuestionCategory questionCategoryStringMapping(String categoryName) {

        return switch (categoryName) {
            case "상품 문의" -> QuestionCategory.PRODUCT_Q;
            case "배송 문의" -> QuestionCategory.DELIVERY_Q;
            case "교환 문의" -> QuestionCategory.EXCHANGE_Q;
            case "환불/취소 문의" -> QuestionCategory.REFUND_CANCEL_Q;
            case "기타" -> QuestionCategory.OTHER_Q;
            default -> null;
        };
    }

    public AnswerStatus answerStatusStringMapping(String answerStatus) {

        return switch (answerStatus) {
            case "답변 대기" -> AnswerStatus.BEFORE_ANSWER;
            case "답변 완료" -> AnswerStatus.ANSWER_COMPLETE;
            default -> null;
        };
    }
}
