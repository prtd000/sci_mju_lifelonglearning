package lifelong.model;

import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;

public class RequestOpenCourseFormItem {

    private Date startRegister;
    private Date endRegister;
    private int quantity;
    private Date startStudyDate;
    private Date endStudyDate;
    private String studyTime;
    private String type_learn;
    private String type_teach;
    private Date applicationResult;
    private String location;
    private Boolean requestStatus;
    private String signature;
    private String course_id;
    private String lecturer_username;

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

    public Boolean getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(Boolean requestStatus) {
        this.requestStatus = requestStatus;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public String getLecturer_username() {
        return lecturer_username;
    }

    public void setLecturer_username(String lecturer_username) {
        this.lecturer_username = lecturer_username;
    }
}
