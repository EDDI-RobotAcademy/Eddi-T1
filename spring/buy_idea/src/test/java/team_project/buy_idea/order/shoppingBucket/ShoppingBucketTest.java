package team_project.buy_idea.order.shoppingBucket;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketRequest;
import team_project.buy_idea.entity.order.shoppingBucket.ShoppingBucketItem;
import team_project.buy_idea.repository.order.shopppingBucket.ShoppingBucketProductRepository;
import team_project.buy_idea.repository.product.mapping.ProductImageMapping;
import team_project.buy_idea.service.member.MemberService;
import team_project.buy_idea.service.member.request.MemberSignInRequest;
import team_project.buy_idea.service.member.request.MemberSignUpRequest;
import team_project.buy_idea.service.order.shopppingbucket.ShoppingBucketService;
import team_project.buy_idea.service.product.ProductService;
import team_project.buy_idea.service.security.RedisService;

import java.util.List;
import java.util.Map;

@SpringBootTest
public class ShoppingBucketTest {

    @Autowired
    private ShoppingBucketService shoppingBucketService;

    @Autowired
    private ShoppingBucketProductRepository shoppingBucketProductRepository;

    @Autowired
    private MemberService memberService;

    @Autowired
    private RedisService redisService;

    @Autowired
    private ProductService productService;

    @Test
    void SignUp() {
//        1. 회원가입
        MemberSignUpRequest signUpRequest = new MemberSignUpRequest("vvvv", "vvvv", "vvvv", "일반회원");

        memberService.signUp(signUpRequest);
    }

    @Test
    String SignIn() {
        //2.로그인
        MemberSignInRequest signInRequest = new MemberSignInRequest("vvvv", "vvvv", "일반회원");

        Map<String, String> memberInfo = memberService.signIn(signInRequest);
        String token = memberInfo.get("userToken");
        return token;
    }

    @Test
    void registerShoppingBucket() {
        String token = SignIn();

        ShoppingBucketRequest shoppingBucketRequest = new ShoppingBucketRequest(token, 2L, 3);

        shoppingBucketService.addProductToShoppingBucket(shoppingBucketRequest);
    }
}
