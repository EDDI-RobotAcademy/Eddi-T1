package team_project.buy_idea.entity.order;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@NoArgsConstructor
public class OrderInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String orderNo;

    @Column
    private Date orderDate;

    @Column(nullable = false)
    private String buyer;

    @Column(nullable = false)
    private String seller;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private int quantity;

    @Column(nullable = false)
    private int price;


    private Address addressInfo;


    @Column(nullable = false)
    private String orderStatus;


    public OrderInfo(String buyer, String seller, String title, int quantity, int price, Address addressInfo, String orderStatus) {
    /*
        this.orderNo = orderNo;
        this.orderDate = orderDate; */
        this.buyer = buyer;
        this.seller = seller;
        this.title = title;
        this.quantity = quantity;
        this.price = price;
        this.addressInfo = addressInfo;
        this.orderStatus = orderStatus;

    }


}
