package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

@Entity
@Table(name = "imgs")
public class AddImg {
    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    private long id;

    @Column
    private String detail;

    @Column
    private String pdf;

    public AddImg() {
    }

    public AddImg(long id, String detail, String pdf) {
        this.id = id;
        this.detail = detail;
        this.pdf = pdf;
    }

    public AddImg(String detail, String pdf) {
        this.detail = detail;
        this.pdf = pdf;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getImg() {
        return pdf;
    }

    public void setImg(String img) {
        this.pdf = img;
    }
}

