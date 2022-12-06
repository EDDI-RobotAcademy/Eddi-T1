package team_project.buy_idea.controller.member.account;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.service.member.BuyDiaMemberService;

@Slf4j
@RestController
@RequestMapping("/member")
@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
public class MemberController {

    @Autowired
    private BuyDiaMemberService memberService;

    @PostMapping("/check-id/{memberId}")
    public Boolean memberIdDuplicateCheck(@PathVariable("memberId") String memberId) {
        log.info("memberIdDuplicateCheck" + memberId);

        return memberService.memberIdValidation(memberId);
    }
}
