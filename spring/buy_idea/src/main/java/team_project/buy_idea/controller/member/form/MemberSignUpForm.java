package team_project.buy_idea.controller.member.form;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import team_project.buy_idea.service.member.request.MemberSignUpRequest;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberSignUpForm {

    private String memberId;
    private String nickname;
    private String password;
    private String memberType;

    public MemberSignUpRequest toMemberSignUpRequest() {
        return new MemberSignUpRequest(memberId, nickname, password, memberType);
    }

}