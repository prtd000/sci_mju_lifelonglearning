package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "receipt")
public class Receipt {

    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private String receipt_id;

    @Column(name = "receipt_Paydate",nullable = false)
    private Date pay_date;

    @Column(name = "receipt_Paytime",nullable = false,length = 50)
    private String pay_time;

    @Column(name = "receipt_banking",nullable = false,length = 150)
    private String banking;

    @Column(name = "receipt_total",nullable = false,length = 10)
    private double total;

    @OneToOne
    @JoinColumn(name="invoice_id",nullable = false)
    private Invoice invoice;

//    @OneToOne(mappedBy = "receipt", cascade = CascadeType.ALL)
//    private Register register;
}
