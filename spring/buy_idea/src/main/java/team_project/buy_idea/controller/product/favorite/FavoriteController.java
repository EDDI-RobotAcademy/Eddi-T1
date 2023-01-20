package team_project.buy_idea.controller.product.favorite;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.product.favorite.request.FavoriteRequest;
import team_project.buy_idea.service.product.favorite.FavoriteService;
import team_project.buy_idea.service.product.favorite.response.FavoriteResponse;

@Slf4j
@RestController
@RequestMapping("/favorite")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    @PostMapping("/status")
    public FavoriteResponse productFavoriteStatus(@RequestBody FavoriteRequest request) {
        log.info("productFavoriteStatus()");
        log.info("request : " + request.toString());

        return favoriteService.favoriteStatus(request);
    }

}
