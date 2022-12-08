package team_project.buy_idea.controller.member;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.member.form.MemberSignInForm;
import team_project.buy_idea.controller.member.form.MemberSignUpForm;
import team_project.buy_idea.service.member.MemberService;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/member")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @PostMapping("/check-id/{memberId}")
    public Boolean memberIdDuplicateCheck(@PathVariable("memberId") String memberId) {
        log.info("memberIdDuplicateCheck()" + memberId);

        return memberService.memberIdValidation(memberId);
    }

    @PostMapping("/check-nickname/{nickname}")
    public Boolean memberNicknameDuplicateCheck(@PathVariable("nickname") String nickname) {
        log.info("memberNicknameDuplicateCheck()" + nickname);

        return memberService.memberNicknameValidation(nickname);
    }

    @PostMapping("/sign-in")
    public Map<String, String> signIn(@RequestBody MemberSignInForm form) {
        log.info("signIn : " + form);

        return memberService.signIn(form.toSignInRequest());
    }

    @PostMapping("/sign-up")
    public Boolean signUp(@RequestBody MemberSignUpForm form) {
        log.info("signUp: " + form);

        return memberService.signUp(form.toMemberSignUpRequest());
    }
}