package team_project.buy_idea.member;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import team_project.buy_idea.entity.member.Member;
import team_project.buy_idea.repository.member.MemberRepository;
import team_project.buy_idea.service.member.MemberService;
import team_project.buy_idea.service.member.request.MemberNicknameModifyRequest;
import team_project.buy_idea.service.member.request.MemberSignUpRequest;
import team_project.buy_idea.service.member.request.MemberSignInRequest;

import java.util.Map;
import java.util.Optional;

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
        MemberSignInRequest request = new MemberSignInRequest("gggg","gggg", "일반회원");

        Map<String, String> memberInfo = service.signIn(request);
        String token = memberInfo.get("userToken");
        System.out.println(token);
    }

    @Test
    void memberNicknameModify() {
        MemberNicknameModifyRequest request = new MemberNicknameModifyRequest(
                "modifyNickname", "일반회원테스트"
        );

        Map<String, String> modifyNickname = service.nicknameModify(request);
        System.out.println(modifyNickname.get("nickname"));
    }

    @Test
    void deleteMember(){
        String token = "217c6dee-3835-462a-b2ac-ad941375f790";
        service.deleteMember(token);
    }
}
