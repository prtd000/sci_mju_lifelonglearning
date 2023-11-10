package lifelong.service;

import lifelong.model.*;

import java.util.List;

public interface RequestOpCourseService {
    List<Lecturer> getLecturer();
    Lecturer getLecturerDetail(String lecUser);

    RequestOpenCourse getRequestOpCourseByCourseId (String courseId);

    void saveRequestOpenCourse (RequestOpenCourse requestOpenCourse);
    List<RequestOpenCourse> getRequestOpenCourses();
    List<RequestOpenCourse> getRequestOpenCoursesByTypeRegister();
    List<RequestOpenCourse> getRequestOpenCoursesByTypeMaxRegister();
    List<RequestOpenCourse> getRequestOpenCoursesByTypePayment();
    List<RequestOpenCourse> getRequestOpenCoursesByTypeStudy();
    List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_id);
    List<RequestOpenCourse> getRequestOpenCoursesByTypePaymentByLec(String lec_id);
    List<RequestOpenCourse> getRequestOpenCoursesByTypeApplicationByLec(String lec_id);
    List<RequestOpenCourse> getRequestOpenCoursesByTypeStudyByLec(String lec_id);
    List<RequestOpenCourse> getRequestOpenCoursesToCheckDateStudy(String lec_id);
    RequestOpenCourse getRequestOpenCourseDetail(long requestId);
    RequestOpenCourse getRequestOpenCourseDetailToUpdate(long roc_id,String lec_id);
    void deleteRequestOpenCourse(long requestId,String lec_id);
    void checkDeleteRequestOpenCourse(long id);
    List<Major> getMajor();
    void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse);
    void updateRequestOpenCourse(RequestOpenCourse requestOpenCourse);
    int getSignatureCourseMaxId();

    int getRequestCourseRoundMaxId(String course_id);
    List<Register> checkRegisterToDelete(long request_id);
    List<RequestOpenCourse> checkRequestOpenCourseByCourseIdToUnApprove(String course_id);

    List<RequestOpenCourse> getRequestOpenCoursesByLecturerIdAndStatus(String lec_id);
    List<Register> getRegistersByRocId(long request_id);
    List<RequestOpenCourse> getRequestCourseByStatus(String status,String lec_id);
    List<RequestOpenCourse> getRequestCourseByTwoStatus(String status1, String status2, String lec_id);
    List<RequestOpenCourse> getRequestCourseByStatusByRegister(String status1, String status2, String status3, String status4,String lec_id);
    List<RequestOpenCourse> getAllRequestByStatusByRegister();
    List<RequestOpenCourse> getNoMaxRequestByStatusByRegister();
    List<RequestOpenCourse> getRegisAndPayRequestByStatusByRegister();
    List<RequestOpenCourse> getPayRequestByStatusByRegister();
    List<RequestOpenCourse> getAllRequestByStatusByMaxRegister();
    List<RequestOpenCourse> getAppRequestByStatusByRegister();
    List<RequestOpenCourse> getAllRequestByStatusByStudy();
    List<RequestOpenCourse> getAllCancelRequestByStatus();
    List<RequestOpenCourse> getAllRequestBeforeApprove();
    List<RequestOpenCourse> getAllRequestByStatusByFinishStudy();

}
