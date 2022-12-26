package team_project.buy_idea.service.order.shopppingbucket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketRequest;
import team_project.buy_idea.entity.member.Member;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucket;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucketItem;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.repository.member.MemberRepository;
import team_project.buy_idea.repository.order.shopppingBucket.ShoppingBucketProductRepository;
import team_project.buy_idea.repository.order.shopppingBucket.ShoppingBucketRepository;
import team_project.buy_idea.repository.product.ProductRepository;
import team_project.buy_idea.service.security.RedisService;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class ShoppingBucketServiceImpl implements ShoppingBucketService{

    @Autowired
    private RedisService redisService;
    @Autowired
    private ShoppingBucketRepository shoppingBucketRepository;

    @Autowired
    private ShoppingBucketProductRepository bucketProductRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ProductRepository productRepository;

    @Override
    public void addProductToShoppingBucket(ShoppingBucketRequest bucketRequest) {
        String memberToken = bucketRequest.getMemberToken();
        Long memberId = redisService.getValueByKey(memberToken);

        Long productId = bucketRequest.getProductId();
        int productAmountValue = bucketRequest.getProductAmountValue();

        Optional<ShoppingBucket> maybeNothingShoppingBucket = shoppingBucketRepository.findByMemberId(memberId);

        if (maybeNothingShoppingBucket.isEmpty()) {
            Optional<Member> maybeMember = memberRepository.findById(memberId);
            Member member = maybeMember.get();

            ShoppingBucket shoppingBucket = ShoppingBucket.builder()
                    .member(member)
                    .shoppingBucketTotalCnt(0)
                    .build();

            shoppingBucketRepository.save(shoppingBucket);
        }

        Optional<ShoppingBucket> maybeShoppingBucket = shoppingBucketRepository.findByMemberId(memberId);
        ShoppingBucket shoppingBucket = maybeShoppingBucket.get();

        Optional<Product> maybeProduct = productRepository.findById(productId);
        Product product = maybeProduct.get();

        ShoppingBucketItem shoppingBucketItem = ShoppingBucketItem.builder()
                .shoppingBucket(shoppingBucket)
                .product(product)
                .itemCount(productAmountValue)
                .build();

        shoppingBucket.setShoppingBucketTotalCnt(shoppingBucket.getShoppingBucketTotalCnt() + 1);
        shoppingBucketRepository.save(shoppingBucket);
        bucketProductRepository.save(shoppingBucketItem);
    }


}
