package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "activity")
public class Activity {

    @Id
//    @GeneratedValue(generator = "increment")
//    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private String ac_id;

    @Column(name = "ac_name",nullable = false)
    private String name;

    @Column(name = "ac_date",nullable = false)
    private Date date;

    @Column(name = "ac_detail",nullable = false)
    private String detail;

    @Column(name = "ac_type",nullable = false,length = 150)
    private String type;

    @Column(columnDefinition = "TEXT",name = "ac_img",nullable = false,length = 200) // ใช้ TEXT สำหรับเก็บ JSON ในฐานข้อมูล
    private String img; // เก็บสตริง JSON ของรายชื่อไฟล์ภาพ

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "request_id")
    private RequestOpenCourse requestOpenCourse;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "lec_username")
    private Lecturer lecturer;

    public Activity() {
    }

    public Activity(String name, Date date, String detail, String type, String img) {
        this.name = name;
        this.date = date;
        this.detail = detail;
        this.type = type;
        this.img = img;
    }

    public Activity(String name, Date date, String detail, String type, String img, RequestOpenCourse requestOpenCourse, Lecturer lecturer) {
        this.ac_id = ac_id;
        this.name = name;
        this.date = date;
        this.detail = detail;
        this.type = type;
        this.img = img;
        this.requestOpenCourse = requestOpenCourse;
        this.lecturer = lecturer;
    }

    public String getAc_id() {
        return ac_id;
    }

    public void setAc_id(String ac_id) {
        this.ac_id = ac_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public RequestOpenCourse getRequestOpenCourse() {
        return requestOpenCourse;
    }

    public void setRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        this.requestOpenCourse = requestOpenCourse;
    }

    public Lecturer getLecturer() {
        return lecturer;
    }

    public void setLecturer(Lecturer lecturer) {
        this.lecturer = lecturer;
    }
}
