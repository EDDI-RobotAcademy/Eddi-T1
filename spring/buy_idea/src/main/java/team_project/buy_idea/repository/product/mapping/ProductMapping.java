package team_project.buy_idea.repository.product.mapping;

// 메인페이지 상품 카드에 필요한 정보만 반환하기 위한 Mapping interface
public interface ProductMapping {
    Long getProductNo();
    String getTitle();
    String getNickname();
    int getPrice();
}
