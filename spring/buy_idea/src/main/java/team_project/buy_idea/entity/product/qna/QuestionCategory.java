package team_project.buy_idea.entity.product.qna;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;

@Getter
public enum QuestionCategory {

    PRODUCT_Q("상품 문의"),
    DELIVERY_Q("배송 문의"),
    EXCHANGE_Q("교환 문의"),
    REFUND_CANCEL_Q("환불/취소 문의"),
    OTHER_Q("기타");

    private final String questionCategory;

    QuestionCategory(String questionCategory){
        this.questionCategory = questionCategory;
    }

    public String questionCategory() {
        return questionCategory;
    }
}
