package team_project.buy_idea.service.member;

import team_project.buy_idea.service.member.request.BuyDiaMemberRegisterRequest;
import team_project.buy_idea.service.member.request.MemberSignInRequest;

public interface BuyDiaMemberService {
    Boolean signUp(BuyDiaMemberRegisterRequest request);

    Boolean memberIdValidation(String memberId);
    Boolean memberNicknameValidation(String nickName);
    String signIn(MemberSignInRequest request);
}
