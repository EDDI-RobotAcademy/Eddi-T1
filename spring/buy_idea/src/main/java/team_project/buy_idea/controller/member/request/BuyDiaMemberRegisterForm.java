package team_project.buy_idea.controller.member.request;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class BuyDiaMemberRegisterForm {

    private String memberId;
    private String nickName;
    private String password;
    private String memberType;


}
