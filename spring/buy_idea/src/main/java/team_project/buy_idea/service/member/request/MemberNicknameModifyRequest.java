package team_project.buy_idea.service.member.request;


import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@RequiredArgsConstructor
public class MemberNicknameModifyRequest {

    private final String nickname;
    private final String currentNickname;
}
