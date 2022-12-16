package team_project.buy_idea.controller.member.form;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import team_project.buy_idea.service.member.request.MemberNicknameModifyRequest;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberNicknameModifyForm {

    private String nickname;
    private String currentNickname;

    public MemberNicknameModifyRequest toNicknameModifyRequest(){
        return new MemberNicknameModifyRequest(nickname, currentNickname);
    }
}
