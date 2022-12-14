package team_project.buy_idea.member;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import team_project.buy_idea.service.member.MemberService;
import team_project.buy_idea.service.member.request.MemberSignUpRequest;
import team_project.buy_idea.service.member.request.MemberSignInRequest;

@SpringBootTest
public class MemberTest {

    @Autowired
    private MemberService service;

    @Test
    void memberSignUpTest() {
        MemberSignUpRequest registerRequest = new MemberSignUpRequest("qkrtjsgh", "호호", "q123123!", "일반회원");


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
    @Transactional
    void memberSignInTest() {
        MemberSignInRequest request = new MemberSignInRequest("qkrtjsgh","q123123!", "일반회원");

        String token = service.signIn(request);
        System.out.println(token);
    }
}
