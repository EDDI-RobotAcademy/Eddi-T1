package team_project.buy_idea.entity.order;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Setter
@Getter
@Embeddable
@NoArgsConstructor
@AllArgsConstructor
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String orderNo;

    @Column(nullable = false)
    private String buyer;

    @Column(nullable = false)
    private String phone;

    @Column(nullable = false)
    private String zipcode;

    @Column(nullable = false)
    private String city;

    @Column(nullable = false)
    private String street;

    @Column(nullable = false)
    private String addressDetail;

    /*
    public static Address of(String city, String street, String addressDetail, String zipcode) {
        return new Address(city, street, addressDetail, zipcode);
    }
    */


}
