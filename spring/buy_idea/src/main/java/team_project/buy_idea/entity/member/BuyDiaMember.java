package team_project.buy_idea.entity.member;


import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
public class BuyDiaMember {

    @Id
    @Getter
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Getter
    @Column(nullable = false)
    private String memberId;

    @Getter
    @Column(nullable = false)
    private String nickName;



    @OneToMany(mappedBy = "buy_dia_member", fetch = FetchType.LAZY)
    private Set<Authentication> authentications = new HashSet<>();

    @Getter
    @Column(nullable = false)
    private String memberType;


    public BuyDiaMember(String memberId, String nickName, String password, String memberType) {

        this.memberId = memberId;
        this.nickName = nickName;

        this.memberType = memberType;
    }

    private Optional<Authentication> findBasicAuthentication() {
        return authentications
                .stream()
                .filter(auth -> auth instanceof BasicAuthentication)
                .findFirst();
    }

    public boolean isRightPassword(String plainToCheck) {
        final Optional<Authentication> maybeBasicAuth = findBasicAuthentication();

        if (maybeBasicAuth.isPresent()) {
            final BasicAuthentication auth = (BasicAuthentication) maybeBasicAuth.get();
            return auth.isRightPassword(plainToCheck);
        }

        return false;
    }
}
