package team_project.buy_idea.service.order.shopppingbucket;


import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketRequest;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucketItem;

import java.util.List;

public interface ShoppingBucketService {

    public void addProductToShoppingBucket(ShoppingBucketRequest bucketRequest);

    public List<ShoppingBucketItem> shoppingBucketItemList(String nickname);

    public void deleteShoppingBucketProduct(Long itemId);
}
