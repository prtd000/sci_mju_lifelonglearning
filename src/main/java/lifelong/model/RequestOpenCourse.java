package lifelong.model;

import org.hibernate.annotations.GenericGenerator;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "request_open_course")
public class RequestOpenCourse {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //Auto Increment
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private long request_id;

    @Column(length = 10)
    private int round;

    @Column(nullable = false)
    private Date requestDate;
    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date startRegister;

    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date endRegister;

    @Column(nullable = false,length = 5)
    private int quantity;

    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date startStudyDate;

    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date endStudyDate;

    @Column(nullable = false,length = 20)
    private String studyTime;

    @Column(nullable = false, length = 100)
    private String type_learn;

    @Column(length = 200)
    private String type_teach;

    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date applicationResult;

    @Column
    private String location;

    @Column(name = "course_linkMooc")
    private String linkMooc;

    @Column(nullable = false)
    private String requestStatus;

    @Column(name = "signature",nullable = false,length = 200)
    private String signature;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "course_id")
    private Course course;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "lec_username")
    private Lecturer lecturer;

    @OneToMany(mappedBy = "requestOpenCourse", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<Register> registerList = new ArrayList<>();


    // เมธอดเพื่อเพิ่มข้อมูล Register เข้า List
    public int getNumberOfApprovedRegistrations() {
        int count = 0;
        for (Register register : registerList) {
            if (register.getInvoice() != null && "ผ่าน".equals(register.getInvoice().getApprove_status())) {
                count++;
            }
        }
        return count;
    }
    public int getNumberOfAllRegistrations() {
        int count = 0;
        for (Register register : registerList) {
            count++;
        }
        return count;
    }
    // สร้างเมธอดเพื่อนับจำนวนคนที่สมัครสำหรับหลักสูตรนี้
    // เมธอดเพื่อนับจำนวน Register ที่มีใน List
//    public int getNumberOfRegistrations() {
//        return registerList.size();
//    }

    public RequestOpenCourse() {
    }

    public RequestOpenCourse(int round, Date requestDate, Date startRegister, Date endRegister, int quantity, Date startStudyDate, Date endStudyDate, String studyTime, String type_learn, String type_teach, Date applicationResult, String requestStatus, String signature, Course course, Lecturer lecturer) {
        this.round = round;
        this.requestDate = requestDate;
        this.startRegister = startRegister;
        this.endRegister = endRegister;
        this.quantity = quantity;
        this.startStudyDate = startStudyDate;
        this.endStudyDate = endStudyDate;
        this.studyTime = studyTime;
        this.type_learn = type_learn;
        this.type_teach = type_teach;
        this.applicationResult = applicationResult;
        this.requestStatus = requestStatus;
        this.signature = signature;
        this.course = course;
        this.lecturer = lecturer;
    }

    public void checkEndDate() {
        Date currentDate = new Date(); // วันปัจจุบัน

        if(!Objects.equals(requestStatus, "เสร็จสิ้น")){
            if (currentDate.after(endStudyDate) && Objects.equals(requestStatus, "ผ่าน")) {
                // ถ้าวันปัจจุบันหลังจาก endStudyDate
                this.requestStatus = "เสร็จสิ้น"; // เปลี่ยนค่า requestStatus เป็น "เสร็จสิ้น"
                this.course.setStatus("ยังไม่เปิดสอน");
                for (Register register : registerList) {
                    if(Objects.equals(register.getInvoice().getApprove_status(), "ผ่าน")){
                        if (currentDate.after(endStudyDate) && Objects.equals(register.getStudy_result(), "กำลังเรียน")) {
                            register.setStudy_result("ไม่ผ่าน");
                        }
                    }
                }
            }
        }
    }


    public long getRequest_id() {
        return request_id;
    }

    public void setRequest_id(long request_id) {
        this.request_id = request_id;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public Date getStartRegister() {
        return startRegister;
    }

    public void setStartRegister(Date startRegister) {
        this.startRegister = startRegister;
    }

    public Date getEndRegister() {
        return endRegister;
    }

    public void setEndRegister(Date endRegister) {
        this.endRegister = endRegister;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getStartStudyDate() {
        return startStudyDate;
    }

    public void setStartStudyDate(Date startStudyDate) {
        this.startStudyDate = startStudyDate;
    }

    public Date getEndStudyDate() {
        return endStudyDate;
    }

    public void setEndStudyDate(Date endStudyDate) {
        this.endStudyDate = endStudyDate;
    }

    public String getStudyTime() {
        return studyTime;
    }

    public void setStudyTime(String studyTime) {
        this.studyTime = studyTime;
    }

    public String getType_learn() {
        return type_learn;
    }

    public void setType_learn(String type_learn) {
        this.type_learn = type_learn;
    }

    public String getType_teach() {
        return type_teach;
    }

    public void setType_teach(String type_teach) {
        this.type_teach = type_teach;
    }

    public Date getApplicationResult() {
        return applicationResult;
    }

    public void setApplicationResult(Date applicationResult) {
        this.applicationResult = applicationResult;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getLinkMooc() {
        return linkMooc;
    }

    public void setLinkMooc(String linkMooc) {
        this.linkMooc = linkMooc;
    }

    public String getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(String requestStatus) {
        this.requestStatus = requestStatus;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
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

    public int getRound() {
        return round;
    }

    public void setRound(int round) {
        this.round = round;
    }

}

