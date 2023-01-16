package team_project.buy_idea.entity.seller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import team_project.buy_idea.entity.member.Member;

import javax.persistence.*;

@Entity
@Data
@ToString(exclude = {"member", "companyInfo"})
@NoArgsConstructor
@AllArgsConstructor
public class SellerProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @Column(nullable = false)
    private String realName;

    @Column(nullable = false)
    private String phone;

    @Column(nullable = false)
    private String registrationNumber;

    @OneToOne(fetch = FetchType.LAZY, mappedBy = "sellerProfile", cascade = CascadeType.ALL)
    private CompanyInfo companyInfo;

}
