package team_project.buy_idea.order.shoppingBucket;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketDeleteRequest;
import team_project.buy_idea.controller.order.shoppingBucket.request.ShoppingBucketRequest;
import team_project.buy_idea.service.member.MemberService;
import team_project.buy_idea.service.member.request.MemberSignInRequest;
import team_project.buy_idea.service.member.request.MemberSignUpRequest;
import team_project.buy_idea.service.order.shopppingbucket.ShoppingBucketService;

import java.util.List;
import java.util.Map;

@SpringBootTest
public class ShoppingBucketTest {

    @Autowired
    private ShoppingBucketService shoppingBucketService;

    @Autowired
    private MemberService memberService;

    @Test
    void SignUp() {
//        1. 회원가입
        MemberSignUpRequest signUpRequest = new MemberSignUpRequest("wwww", "wwww", "wwww", "일반회원");

        memberService.signUp(signUpRequest);
    }

    @Test
    String SignIn() {
        //2.로그인
        MemberSignInRequest signInRequest = new MemberSignInRequest("wwww", "wwww", "일반회원");

        Map<String, String> memberInfo = memberService.signIn(signInRequest);
        String token = memberInfo.get("userToken");
        return token;
    }

    @Test
    void registerShoppingBucket() {
        String nickname = "wwww";

        ShoppingBucketRequest shoppingBucketRequest = new ShoppingBucketRequest(nickname, 20L, 1);

        shoppingBucketService.addProductToShoppingBucket(shoppingBucketRequest);
    }

    @Test
    void getShoppingBucketItemList() {
        String nickname = "wwww";

        System.out.println(shoppingBucketService.shoppingBucketItemList(nickname));
    }

    @Test
    void deleteShoppingBucketProduct(){
        ShoppingBucketDeleteRequest shoppingBucketDeleteRequest = new ShoppingBucketDeleteRequest("jjjj", 3L);

        shoppingBucketService.deleteShoppingBucketProduct(shoppingBucketDeleteRequest);
    }
}
