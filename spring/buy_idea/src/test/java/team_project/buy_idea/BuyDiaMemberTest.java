package team_project.buy_idea;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.service.member.BuyDiaMemberService;
import team_project.buy_idea.service.member.request.BuyDiaMemberRegisterRequest;
import team_project.buy_idea.service.member.request.MemberSignInRequest;

@SpringBootTest
public class BuyDiaMemberTest {

    @Autowired
    private BuyDiaMemberService service;

    @Test
    void memberSignUpTest() {
        BuyDiaMemberRegisterRequest registerRequest = new BuyDiaMemberRegisterRequest("qkrtjsgh", "호호", "q123123!", "일반회원");


        service.signUp(registerRequest);
    }

    @Test
    void memberIdValidationTest(){
        String memberId = "ljb8194";

        boolean validationValue = service.memberIdValidation(memberId);
        System.out.println(validationValue);
    }

    @Test
    void memberNicknameValidationTest(){
        String nickName = "Geon";

        boolean validationValue = service.memberNicknameValidation(nickName);
        System.out.println(validationValue);
    }

    @Test
    void memberSignInTest() {
        MemberSignInRequest request = new MemberSignInRequest("qkrtjsgh","q123123!");

        String token = service.signIn(request);
        System.out.println(token);
    }
}
