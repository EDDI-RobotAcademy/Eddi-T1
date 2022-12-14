package team_project.buy_idea.service.member.request;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import team_project.buy_idea.entity.member.Member;

@Getter
@ToString
@RequiredArgsConstructor
public class MemberSignUpRequest {

    private final String memberId;
    private final String nickName;
    private final String password;
    private final String memberType;

    public Member toMember() {
        return new Member(
                memberId, nickName, memberType
        );
    }
}

