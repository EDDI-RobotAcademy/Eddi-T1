package team_project.buy_idea.entity.member;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @Column(nullable = false)
    private String memberId;


    @Column(nullable = false)
    private String nickname;

    @OneToMany(mappedBy = "member", fetch = FetchType.EAGER)
    private Set<Authentication> authentications = new HashSet<>();

    @Column(nullable = false)
    private String memberType;


    public Member(String memberId, String nickname, String memberType) {
        this.memberId = memberId;
        this.nickname = nickname;
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