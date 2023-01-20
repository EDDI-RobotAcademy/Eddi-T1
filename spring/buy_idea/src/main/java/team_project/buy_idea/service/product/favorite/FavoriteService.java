package team_project.buy_idea.service.product.favorite;

import team_project.buy_idea.controller.product.favorite.request.FavoriteRequest;
import team_project.buy_idea.service.product.favorite.response.FavoriteResponse;

public interface FavoriteService {

    public FavoriteResponse favoriteStatus(FavoriteRequest request);
}
