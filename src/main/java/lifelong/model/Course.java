package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "course")
public class Course {

    @Id
//    @GeneratedValue(generator = "increment")
//    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private String course_id;

    @Column(name = "course_name",nullable = false)
    private String name;

    @Column(name = "course_certificateName",nullable = false,length = 200)
    private String certificateName;

    @Column(name = "course_img",nullable = false,length = 200)
    private String img;

    @Column(name = "course_principle")
    private String principle;

    @Column(name = "course_object",nullable = false)
    private String object;

    @Column(nullable = false,length = 5)
    private int totalHours;

    @Column(name = "course_targetOccupation")
    private String targetOccupation;

    @Column(name = "course_fee",nullable = false,length = 10)
    private double fee;

    @Column(name = "course_file",nullable = false,length = 200)
    private String file;

    @Column(name = "course_status",nullable = false,length = 100)
    private String status;

    @Column(name = "course_type",nullable = false,length = 50)
    private String course_type;

    @Column(name = "contact")
    private String contact;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "major_id",nullable = false)
    private Major major;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "teaching_schedule",
            joinColumns = { @JoinColumn(name = "course_id") },
            inverseJoinColumns = { @JoinColumn(name = "lec_username",nullable = false) })
    private Set<Lecturer> lecturers;

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL)
    private List<RequestOpenCourse> requests;
    public Course() {
    }

    public Course(String name, String certificateName, String img, String principle, String object, int totalHours, String targetOccupation, double fee, String file, String status, String course_type, Major major,String contact) {
        this.name = name;
        this.certificateName = certificateName;
        this.img = img;
        this.principle = principle;
        this.object = object;
        this.totalHours = totalHours;
        this.targetOccupation = targetOccupation;
        this.fee = fee;
        this.file = file;
        this.status = status;
        this.course_type = course_type;
        this.major = major;
        this.contact = contact;
    }

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCertificateName() {
        return certificateName;
    }

    public void setCertificateName(String certificateName) {
        this.certificateName = certificateName;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getPrinciple() {
        return principle;
    }

    public void setPrinciple(String principle) {
        this.principle = principle;
    }

    public String getObject() {
        return object;
    }

    public void setObject(String object) {
        this.object = object;
    }

    public int getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(int totalHours) {
        this.totalHours = totalHours;
    }

    public String getTargetOccupation() {
        return targetOccupation;
    }

    public void setTargetOccupation(String targetOccupation) {
        this.targetOccupation = targetOccupation;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Major getMajor() {
        return major;
    }

    public void setMajor(Major major) {
        this.major = major;
    }

    public String getCourse_type() {
        return course_type;
    }

    public void setCourse_type(String course_type) {
        this.course_type = course_type;
    }

    public Set<Lecturer> getLecturers() {
        return lecturers;
    }

    public void setLecturers(Set<Lecturer> lecturers) {
        this.lecturers = lecturers;
    }

    public List<RequestOpenCourse> getRequests() {
        return requests;
    }

    public void setRequests(List<RequestOpenCourse> requests) {
        this.requests = requests;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }
}
