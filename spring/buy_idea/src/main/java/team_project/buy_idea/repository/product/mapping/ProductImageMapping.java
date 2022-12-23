package team_project.buy_idea.repository.product.mapping;

// 이미지의 path와 originName을 제외하고 imageId, editedName만 반환하기 위한 Mapping interface
public interface ProductImageMapping {
    Long getImageId();
    String getEditedName();
}
