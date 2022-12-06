package team_project.buy_idea;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.repository.member.BuyDiaMemberRepository;
import team_project.buy_idea.service.member.BuyDiaMemberService;
import team_project.buy_idea.service.member.request.BuyDiaMemberRegisterRequest;

@SpringBootTest
public class BuyDiaRegisterTest {

    @Autowired
    private BuyDiaMemberService service;

    @Test
    void memberSignUpTest() {
        BuyDiaMemberRegisterRequest registerRequest = new BuyDiaMemberRegisterRequest("ljb8194", "JBTV", "123456", "일반회원");


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
}
