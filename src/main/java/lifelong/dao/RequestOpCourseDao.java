package lifelong.dao;

import lifelong.model.*;

import java.util.List;

public interface RequestOpCourseDao {
    List<Lecturer> getLecturer();
    Lecturer getLecturerDetail(String id);

    RequestOpenCourse getRequestOpCourseByCourseId (String courseId);
    List<RequestOpenCourse> getRequestOpenCourses();
    List<RequestOpenCourse> getRequestOpenCoursesByTypeRegister();
    List<RequestOpenCourse> getRequestOpenCoursesByTypeMaxRegister();
    List<RequestOpenCourse> getRequestOpenCoursesByTypePayment();
    List<RequestOpenCourse> getRequestOpenCoursesByTypeStudy();
    List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_id);
    List<RequestOpenCourse> getRequestOpenCoursesByTypePaymentByLec(String lec_id);
    List<RequestOpenCourse> getRequestOpenCoursesByTypeApplicationByLec(String lec_id);
    List<RequestOpenCourse> getRequestOpenCoursesByTypeStudyByLec(String lec_id);
    List<RequestOpenCourse> getRequestOpenCoursesByLecturerIdAndStatus(String lec_id);

    List<RequestOpenCourse> getRequestOpenCoursesToCheckDateStudy(String lec_id);
    RequestOpenCourse getRequestOpenCourseDetail(long id);
    List<RequestOpenCourse> checkRequestOpenCourseByCourseIdToUnApprove(String course_id);
    RequestOpenCourse getRequestOpenCourseDetailToUpdate(long roc_id,String lec_id);

    void saveRequestOpenCourse (RequestOpenCourse requestOpenCourse);
    void deleteRequestOpenCourse(long id,String lec_id);
    void checkDeleteRequestOpenCourse(long id);
    RequestOpenCourse updateRequestOpenCourse (RequestOpenCourse requestOpenCourse) ;

    List<Major> getMajors();
    void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse);

    long getLatestId();

    int getSignatureCourseMaxId();
    int getRequestCourseRoundMaxId(String course_id);
    List<Register> checkRegisterToDelete(long request_id);

    List<Register> getRegistersByRocId(long request_id);
}
