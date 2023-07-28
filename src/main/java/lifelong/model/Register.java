package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="register")
public class Register {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //Auto Increment
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private long register_id;

    @Column(nullable = false)
    private Date register_date;

    @Column(nullable = false)
    private Boolean study_result;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "mem_username")
    private Member member;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "request_id")
    private RequestOpenCourse requestOpenCourse;

    public Register() {
    }

    public Register(long register_id, Date register_date, Boolean study_result, Member member, RequestOpenCourse requestOpenCourse) {
        this.register_id = register_id;
        this.register_date = register_date;
        this.study_result = study_result;
        this.member = member;
        this.requestOpenCourse = requestOpenCourse;
    }

    public long getRegister_id() {
        return register_id;
    }

    public void setRegister_id(long register_id) {
        this.register_id = register_id;
    }

    public Date getRegister_date() {
        return register_date;
    }

    public void setRegister_date(Date register_date) {
        this.register_date = register_date;
    }

    public Boolean getStudy_result() {
        return study_result;
    }

    public void setStudy_result(Boolean study_result) {
        this.study_result = study_result;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public RequestOpenCourse getRequestOpenCourse() {
        return requestOpenCourse;
    }

    public void setRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        this.requestOpenCourse = requestOpenCourse;
    }
}
