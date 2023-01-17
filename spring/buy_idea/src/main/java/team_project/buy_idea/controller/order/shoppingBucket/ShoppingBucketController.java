package team_project.buy_idea.controller.order.shoppingBucket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketDeleteRequest;
import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketRequest;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucketItem;
import team_project.buy_idea.service.order.shopppingbucket.ShoppingBucketService;
import team_project.buy_idea.service.security.RedisService;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/order")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ShoppingBucketController {

    @Autowired
    private ShoppingBucketService bucketService;

    @PostMapping("/register/shopping-bucket")
    public void registerShoppingBucket(@RequestBody ShoppingBucketRequest bucketRequest) {
        log.info("registerShoppingBucket " + bucketRequest.toString());

        bucketService.addProductToShoppingBucket(bucketRequest.toShoppingBucketRequest());
    }

    @PostMapping("/shopping-bucket-list/{nickname}")
    public List<ShoppingBucketItem> shoppingBucketItemList(@PathVariable("nickname") String nickname) {
        log.info("shoppingBucketItemList " + nickname);

        return bucketService.shoppingBucketItemList(nickname);
    }

    @DeleteMapping("/shopping-bucket-list")
    public void deleteShoppingBucketProduct(@RequestBody ShoppingBucketDeleteRequest bucketDeleteRequest) {
        log.info("deleteShoppingBucketProduct" + bucketDeleteRequest.getNickname());

        bucketService.deleteShoppingBucketProduct(bucketDeleteRequest);
    }
}
