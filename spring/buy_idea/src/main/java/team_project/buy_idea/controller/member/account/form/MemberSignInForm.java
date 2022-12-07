package team_project.buy_idea.controller.member.account.form;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import team_project.buy_idea.service.member.request.MemberSignInRequest;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberSignInForm {
    private String memberId;
    private String password;

    public MemberSignInRequest toSignInRequest() {
        return new MemberSignInRequest(memberId, password);
    }
}
