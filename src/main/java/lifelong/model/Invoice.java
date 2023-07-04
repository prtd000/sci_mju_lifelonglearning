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

    @Column(nullable = false)
    private Date startPayment;

    @Column(nullable = false)
    private Date endPayment;

    @Column(nullable = false,length = 100)
    private String pay_status;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "register_id")
    private Register register;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "request_id")
    private RequestOpenCourse requestOpenCourse;

    public Invoice() {
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

    public String getPay_status() {
        return pay_status;
    }

    public void setPay_status(String pay_status) {
        this.pay_status = pay_status;
    }

    public Register getRegister() {
        return register;
    }

    public void setRegister(Register register) {
        this.register = register;
    }

    public RequestOpenCourse getRequestOpenCourse() {
        return requestOpenCourse;
    }

    public void setRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        this.requestOpenCourse = requestOpenCourse;
    }
}
