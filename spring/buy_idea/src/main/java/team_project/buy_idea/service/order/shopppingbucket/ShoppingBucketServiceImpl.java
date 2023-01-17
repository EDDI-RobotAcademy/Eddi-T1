package team_project.buy_idea.service.order.shopppingbucket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketDeleteRequest;
import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketRequest;
import team_project.buy_idea.entity.member.Member;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucket;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucketItem;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.repository.member.MemberRepository;
import team_project.buy_idea.repository.order.shopppingBucket.ShoppingBucketProductRepository;
import team_project.buy_idea.repository.order.shopppingBucket.ShoppingBucketRepository;
import team_project.buy_idea.repository.product.ProductRepository;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class ShoppingBucketServiceImpl implements ShoppingBucketService{

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

        String nickname = bucketRequest.getNickname();

        Long productId = bucketRequest.getProductId();
        int productAmountValue = bucketRequest.getProductAmountValue();

        Optional<ShoppingBucket> maybeNothingShoppingBucket = shoppingBucketRepository.findByNickname(nickname);

        if (maybeNothingShoppingBucket.isEmpty()) {
            Optional<Member> maybeMember = memberRepository.findBuyDiaMemberByNickname(nickname);
            Member member = maybeMember.get();

            ShoppingBucket shoppingBucket = ShoppingBucket.builder()
                    .member(member)
                    .shoppingBucketTotalCnt(0)
                    .build();

            shoppingBucketRepository.save(shoppingBucket);
        }

        Optional<ShoppingBucket> maybeShoppingBucket = shoppingBucketRepository.findByNickname(nickname);
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

    @Override
    public List<ShoppingBucketItem> shoppingBucketItemList(String nickname) {

        return bucketProductRepository.findShoppingBucketItemListByNickname(nickname);
    }

    @Override
    public void deleteShoppingBucketProduct(ShoppingBucketDeleteRequest shoppingBucketDeleteRequest) {
        String nickname = shoppingBucketDeleteRequest.getNickname();
        List<ShoppingBucketItem> shoppingBucketItems = this.shoppingBucketItemList(nickname);

        if (shoppingBucketItems.isEmpty()){
            Optional<Member> maybeMember = memberRepository.findBuyDiaMemberByNickname(nickname);
            Member member = maybeMember.get();

            ShoppingBucket shoppingBucket = ShoppingBucket.builder()
                    .member(member)
                    .shoppingBucketTotalCnt(0)
                    .build();

            shoppingBucketRepository.save(shoppingBucket);
        } else {
            bucketProductRepository.deleteById(shoppingBucketDeleteRequest.getItemId());
            List<ShoppingBucketItem> shoppingBucketItemList = this.shoppingBucketItemList(nickname);

            if (shoppingBucketItemList.size() >= 0){
                Optional<ShoppingBucket> maybeShoppingBucket = shoppingBucketRepository.findByNickname(nickname);
                ShoppingBucket shoppingBucket = maybeShoppingBucket.get();

                shoppingBucket.setShoppingBucketTotalCnt(shoppingBucket.getShoppingBucketTotalCnt() -1);

                shoppingBucketRepository.save(shoppingBucket);
            } else {
                Optional<ShoppingBucket> maybeShoppingBucket = shoppingBucketRepository.findByNickname(nickname);
                ShoppingBucket shoppingBucket = maybeShoppingBucket.get();

                shoppingBucket.setShoppingBucketTotalCnt(0);

                shoppingBucketRepository.save(shoppingBucket);
            }
        }
    }
}
