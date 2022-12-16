package team_project.buy_idea.service.member;

import team_project.buy_idea.service.member.request.MemberNicknameModifyRequest;
import team_project.buy_idea.service.member.request.MemberSignUpRequest;
import team_project.buy_idea.service.member.request.MemberSignInRequest;

import java.util.Map;

public interface MemberService {
    Boolean signUp(MemberSignUpRequest request);

    Boolean memberIdValidation(String memberId);

    Boolean memberNicknameValidation(String nickname);

    Map<String, String> signIn(MemberSignInRequest request);

    Map<String, String> nicknameModify(MemberNicknameModifyRequest request);

}