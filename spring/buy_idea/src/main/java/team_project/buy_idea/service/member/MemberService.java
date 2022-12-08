package team_project.buy_idea.service.member;

import team_project.buy_idea.service.member.request.MemberSignUpRequest;
import team_project.buy_idea.service.member.request.MemberSignInRequest;

public interface MemberService {
    Boolean signUp(MemberSignUpRequest request);

    Boolean memberIdValidation(String memberId);

    Boolean memberNicknameValidation(String nickName);

    String signIn(MemberSignInRequest request);
}