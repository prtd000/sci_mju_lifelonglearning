package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "receipt")
public class Receipt {

    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY) //Auto Increment
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private long receipt_id;

    @Temporal(TemporalType.DATE)
    @Column(name = "receipt_Paydate",nullable = false)
    private Date pay_date;

    @Column(name = "receipt_Paytime",nullable = false,length = 50)
    private String pay_time;

    @Column(name = "receipt_banking",nullable = false,length = 150)
    private String banking;

    @Column(name = "receipt_lastfourdigits" , nullable = false , length = 4)
    private int last_four_digits;

    @Column(name = "receipt_slip",nullable = false,length = 200)
    private String slip;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "invoice_id")
    private Invoice invoice;

    public Receipt() {
    }

    public Receipt(long receipt_id, Date pay_date, String pay_time, String banking, int last_four_digits, String slip, Invoice invoice) {
        this.receipt_id = receipt_id;
        this.pay_date = pay_date;
        this.pay_time = pay_time;
        this.banking = banking;
        this.last_four_digits = last_four_digits;
        this.slip = slip;
        this.invoice = invoice;
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

    public int getLast_four_digits() {
        return last_four_digits;
    }

    public void setLast_four_digits(int last_four_digits) {
        this.last_four_digits = last_four_digits;
    }

    public String getSlip() {
        return slip;
    }

    public void setSlip(String slip) {
        this.slip = slip;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

}
