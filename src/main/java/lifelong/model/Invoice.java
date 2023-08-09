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
    private long invoice_id;

    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date startPayment;

    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date endPayment;

    @Column(nullable = false,length = 100)
    private boolean pay_status;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "register_id")
    private Register register;

//    @OneToOne(cascade = CascadeType.ALL)
//    @JoinColumn(name = "request_id")
//    private RequestOpenCourse requestOpenCourse;

    public Invoice() {
    }

    public Invoice(long invoice_id, Date startPayment, Date endPayment, boolean pay_status, Register register) {
        this.invoice_id = invoice_id;
        this.startPayment = startPayment;
        this.endPayment = endPayment;
        this.pay_status = pay_status;
        this.register = register;
    }

    public boolean isPay_status() {
        return pay_status;
    }

    public Register getRegister() {
        return register;
    }

    public void setRegister(Register register) {
        this.register = register;
    }

    public long getInvoice_id() {
        return invoice_id;
    }

    public void setInvoice_id(long invoice_id) {
        this.invoice_id = invoice_id;
    }

    public Date getStartPayment() {
        return startPayment;
    }

    public void setStartPayment(Date startPayment) {
        this.startPayment = startPayment;
    }

    public Date getEndPayment() {
        return endPayment;
    }

    public void setEndPayment(Date endPayment) {
        this.endPayment = endPayment;
    }

    public boolean getPay_status() {
        return pay_status;
    }

    public void setPay_status(boolean pay_status) {
        this.pay_status = pay_status;
    }


//    public RequestOpenCourse getRequestOpenCourse() {
//        return requestOpenCourse;
//    }
//
//    public void setRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
//        this.requestOpenCourse = requestOpenCourse;
//    }
}
