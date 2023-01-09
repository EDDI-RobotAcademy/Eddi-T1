package team_project.buy_idea.entity.order;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum OrderStatus {

    PAYMENT_COMPLETE("결제 완료"),
    DELIVERING("배송중"),
    DELIVERED("배송 완료"),
    CANCEL("취소"),
    EXCHANGE("교환"),
    REFUND("환불");

    private final String orderStatus;

}
