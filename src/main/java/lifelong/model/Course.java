package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "course")
public class Course {

    @Id
//    @GeneratedValue(generator = "increment")
//    @GenericGenerator(name = "increment", strategy = "increment")
    @Pattern(regexp="^C[0-9]{4}")
    @Column(length = 10)
    private String course_id;

    @Column(name = "course_name",nullable = false)
    @NotNull
    private String name;

    @Column(name = "course_certificateName",nullable = false,length = 200)
    @NotNull
    private String certificateName;

    @Column(name = "course_img",nullable = false,length = 200)
    @NotNull
    private String img;

    @Column(name = "course_principle")
    @NotNull
    private String principle;

    @Column(name = "course_object",nullable = false)
    @NotNull
    private String object;

    @Column(nullable = false,length = 5)
    @NotNull
    private int totalHours;

    @Column(name = "course_targetOccupation")
    @NotNull
    private String targetOccupation;

    @Column(name = "course_fee",nullable = false,length = 10)
    @NotNull
    private double fee;

    @Column(name = "course_file",nullable = false,length = 200)
    @NotNull
    private String file;

    @Column(name = "course_status",nullable = false,length = 100)
    @NotNull
    private String status;

    @Column(name = "course_linkMooc",nullable = false)
    @NotNull
    private String linkMooc;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "major_id")
    private Major major;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "teaching_schedule",
            joinColumns = { @JoinColumn(name = "course_id") },
            inverseJoinColumns = { @JoinColumn(name = "lec_username",nullable = false) })
    private Set<Lecturer> lecturers;

    public Course() {
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

    public String getLinkMooc() {
        return linkMooc;
    }

    public void setLinkMooc(String linkMooc) {
        this.linkMooc = linkMooc;
    }

    public Major getMajor() {
        return major;
    }

    public void setMajor(Major major) {
        this.major = major;
    }
}
