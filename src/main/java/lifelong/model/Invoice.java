package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "invoice")
public class Invoice {

    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private String invoice_id;

    @Column(nullable = false)
    private Date startPayment;

    @Column(nullable = false)
    private Date endPayment;

    @Column(nullable = false,length = 100)
    private String pay_status;

    @OneToOne
    @JoinColumn(name="register_id",nullable = false)
    private Register register;

//    @OneToOne
//    @JoinColumn(name="request_id",nullable = false)
//    private RequestOpenCourse requestOpenCourse;
}
