package team_project.buy_idea.service.product.favorite;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.product.favorite.request.FavoriteRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.favorite.Favorite;
import team_project.buy_idea.repository.product.ProductRepository;
import team_project.buy_idea.repository.product.favorite.FavoriteRepository;
import team_project.buy_idea.service.product.favorite.response.FavoriteResponse;
import team_project.buy_idea.service.product.favorite.response.MyFavoriteListResponse;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    FavoriteRepository favoriteRepository;

    @Autowired
    ProductRepository productRepository;

    /**
     * 상품 상세페이지 접속시 찜 상태 조회 & 찜 등록/삭제 Service Impl
     *
     * @param request  productNo, nickname, favoriteReference
     * @return 찜 버튼 상태 값
     */
    @Override
    public FavoriteResponse favoriteStatus(FavoriteRequest request) {
        final String PRESS_FAVORITE = "tapFavorites";
        final String FIND_FAVORITE = "findFavorite";
        Optional<Product> maybeProduct = productRepository.findById(request.getProductNo());
        FavoriteResponse favoriteStatusResponse = new FavoriteResponse();
        Product product = maybeProduct.get();

        Optional<Favorite> maybeFavorite = favoriteRepository.findProductNoAndNickname(request.getProductNo(), request.getNickname());

        // 찜 누른 이력 없을 시
        if (maybeFavorite.equals(Optional.empty())) {
            Favorite beforePressingFavorite = new Favorite();

            switch (request.getFavoriteReference()) {
                //찜
                case PRESS_FAVORITE:
                    beforePressingFavorite.setProduct(product);
                    beforePressingFavorite.setNickname(request.getNickname());
                    beforePressingFavorite.setFavoriteStatus(true);
                    favoriteRepository.save(beforePressingFavorite);
                    favoriteStatusResponse.setProductFavoriteStatus(true);
                    return favoriteStatusResponse;
                // 찜 안함
                case FIND_FAVORITE:
                    favoriteStatusResponse.setProductFavoriteStatus(false);
                    return favoriteStatusResponse;
            }
            // 찜 누른 이력 있음
        } else {
            Favorite afterPressingFavorite = maybeFavorite.get();

            switch (request.getFavoriteReference()) {
                case PRESS_FAVORITE:
                    // 찜 false일 때 -> 찜 누름 (DB에 true 값으로 저장)
                    if (!afterPressingFavorite.getFavoriteStatus()) {
                        afterPressingFavorite.setFavoriteStatus(true);
                        favoriteRepository.save(afterPressingFavorite);
                        favoriteStatusResponse.setProductFavoriteStatus(true);
                        return favoriteStatusResponse;
                    } else {
                        //찜 true일 때 -> 찜 취소 (DB에서 삭제)
                        Long favoriteNo = afterPressingFavorite.getFavoriteNo();
                        favoriteRepository.deleteById(favoriteNo);
                        productRepository.save(product);
                        favoriteStatusResponse.setProductFavoriteStatus(false);
                        return favoriteStatusResponse;
                    }
                case FIND_FAVORITE:
                    if (!afterPressingFavorite.getFavoriteStatus()) {
                        favoriteStatusResponse.setProductFavoriteStatus(false);
                        return favoriteStatusResponse;
                    } else {
                        favoriteStatusResponse.setProductFavoriteStatus(true);
                        return favoriteStatusResponse;
                    }
            }
        }
        return favoriteStatusResponse;
    }


    /**
     * 일반회원이 찜한 상품 리스트 반환 Service Impl
     * @param nickname 로그인 중인 회원 닉네임
     * @return 상품 정보 리스트
     */
    public List<MyFavoriteListResponse> myFavoriteListResponses(String nickname) {
        List<Favorite> maybeFavoriteList = favoriteRepository.findMyFavoriteListByNickname(nickname);
        List<MyFavoriteListResponse> responseList = new ArrayList<>();

        for (int i = 0; i < maybeFavoriteList.size(); i++) {
            responseList.add(new MyFavoriteListResponse(
                    maybeFavoriteList.get(i).getProduct().getProductNo(),
                    maybeFavoriteList.get(i).getProduct().getProductImages().get(0).getEditedName(),
                    maybeFavoriteList.get(i).getProduct().getTitle(),
                    maybeFavoriteList.get(i).getProduct().getNickname(),
                    maybeFavoriteList.get(i).getProduct().getPrice()
            ));
        }
        return responseList;
    }
}
