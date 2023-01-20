package team_project.buy_idea.product.favorite;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.controller.product.favorite.request.FavoriteRequest;
import team_project.buy_idea.service.product.favorite.FavoriteService;

@SpringBootTest
@AutoConfigureMockMvc
public class FavoriteTestCase {

    @Autowired
    FavoriteService favoriteService;

    @Test
    void pressFavorites(){
        FavoriteRequest request = new FavoriteRequest(
                49L, "JOKUN", "tapFavorites"
        );
        System.out.println(favoriteService.favoriteStatus(request));
    }

    @Test
    void findFavorite(){
        FavoriteRequest request = new FavoriteRequest(
                49L, "JOKUN", "findFavorite"
        );
        System.out.println(favoriteService.favoriteStatus(request));
    }
}
