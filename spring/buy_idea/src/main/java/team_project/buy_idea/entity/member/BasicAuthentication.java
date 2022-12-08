package team_project.buy_idea.entity.member;


import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import team_project.buy_idea.utility.encrypt.EncryptionUtil;
import team_project.buy_idea.utility.password.PasswordHashConverter;

import javax.persistence.*;

@Entity
@ToString(callSuper = true)
@NoArgsConstructor
@DiscriminatorValue(Authentication.BASIC_AUTH)
public class BasicAuthentication extends Authentication {

    @Setter
    @Column(nullable = false)
    @Convert(converter = PasswordHashConverter.class)
    private String password;

    public BasicAuthentication(Member member, String authenticationType, String password) {
        super(member, authenticationType);
        this.password = password;
    }

    public boolean isRightPassword(String plainToCheck) {
        return EncryptionUtil.checkValidation(plainToCheck, password);
    }
}