package team_project.buy_idea.service.product.favorite.response;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MyFavoriteListResponse {

    private Long productNo;
    private String image;
    private String title;
    private String nickname;
    private int price;

}
