package team_project.buy_idea.service.member.request;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class MemberSignInRequest {

    private final String memberId;
    private final String password;
    private final String memberType;
}
