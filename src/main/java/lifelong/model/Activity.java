package lifelong.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "activity")
public class Activity {

    @Id
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

    @Column(name = "ac_img",nullable = false,length = 200)
    private String img;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "course_id")
    private Course course;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "lec_username")
    private Lecturer lecturer;

    public Activity() {
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

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Lecturer getLecturer() {
        return lecturer;
    }

    public void setLecturer(Lecturer lecturer) {
        this.lecturer = lecturer;
    }
}
