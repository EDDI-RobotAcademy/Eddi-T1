package team_project.buy_idea.entity.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import team_project.buy_idea.entity.product.Product;

import javax.persistence.*;

@Entity
@Data
@ToString(exclude = {"address", "product"} )
@NoArgsConstructor
@AllArgsConstructor
public class OrderInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String orderNo;

    @Column
    private String orderDate;

    @Column(nullable = false)
    private String buyer;

    @Column(nullable = false)
    private int quantity;

    @Column(nullable = false)
    private OrderStatus orderStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_id")
    private DeliveryAddress deliveryAddress;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;
}
