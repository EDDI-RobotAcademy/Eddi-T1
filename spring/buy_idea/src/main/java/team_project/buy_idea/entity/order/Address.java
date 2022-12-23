package team_project.buy_idea.entity.order;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String orderNo;

    @Column(nullable = false)
    private String recipient;

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


    @OneToMany(mappedBy = "address", fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderInfo> orderInfos = new ArrayList<>();

}
