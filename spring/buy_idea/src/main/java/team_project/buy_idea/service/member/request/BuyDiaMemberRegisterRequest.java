package team_project.buy_idea.service.member.request;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import team_project.buy_idea.entity.member.BuyDiaMember;

@Getter
@ToString
@RequiredArgsConstructor
public class BuyDiaMemberRegisterRequest {

    private final String memberId;
    private final String nickName;
    private final String password;
    private final String memberType;


    public BuyDiaMember toMember () {
        return new BuyDiaMember(
         memberId, nickName, password, memberType
        );
    }
}

