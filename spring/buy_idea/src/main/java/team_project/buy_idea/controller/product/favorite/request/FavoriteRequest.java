package team_project.buy_idea.controller.product.favorite.request;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FavoriteRequest {

    private Long productNo;
    private String nickname;
    private String favoriteReference;

}
