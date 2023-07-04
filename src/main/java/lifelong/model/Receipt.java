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
    private long receipt_id;

    @Column(name = "receipt_Paydate",nullable = false)
    private Date pay_date;

    @Column(name = "receipt_Paytime",nullable = false,length = 50)
    private String pay_time;

    @Column(name = "receipt_banking",nullable = false,length = 150)
    private String banking;

    @Column(name = "receipt_total",nullable = false,length = 10)
    private double total;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;

    public Receipt() {
    }

    public long getReceipt_id() {
        return receipt_id;
    }

    public void setReceipt_id(long receipt_id) {
        this.receipt_id = receipt_id;
    }

    public Date getPay_date() {
        return pay_date;
    }

    public void setPay_date(Date pay_date) {
        this.pay_date = pay_date;
    }

    public String getPay_time() {
        return pay_time;
    }

    public void setPay_time(String pay_time) {
        this.pay_time = pay_time;
    }

    public String getBanking() {
        return banking;
    }

    public void setBanking(String banking) {
        this.banking = banking;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }
}
