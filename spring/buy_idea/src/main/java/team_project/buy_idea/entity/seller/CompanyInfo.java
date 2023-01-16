package team_project.buy_idea.entity.seller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CompanyInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String city;

    @Column(nullable = false)
    private String street;

    @Column(nullable = false)
    private String addressDetail;

    @Column(nullable = false)
    private String zipcode;

    @OneToOne(fetch = FetchType.LAZY)
    private SellerProfile sellerProfile;
}
