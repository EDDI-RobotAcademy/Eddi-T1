package team_project.buy_idea.controller.order.shoppingBucket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
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

    @PostMapping("/shopping-bucket-list/{memberToken}")
    public List<ShoppingBucketItem> shoppingBucketItemList(@PathVariable("memberToken") String memberToken) {
        log.info("shoppingBucketItemList " + memberToken);

        return bucketService.shoppingBucketItemList(memberToken);
    }
}
