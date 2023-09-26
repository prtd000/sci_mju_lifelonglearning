package lifelong.service;

import lifelong.model.*;

import java.util.List;

public interface RequestOpCourseService {
    List<Lecturer> getLecturer();
    Lecturer getLecturerDetail(String lecUser);

    RequestOpenCourse getRequestOpCourseByCourseId (String courseId);

    void saveRequestOpenCourse (RequestOpenCourse requestOpenCourse);
    List<RequestOpenCourse> getRequestOpenCourses();
    List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_id);
    RequestOpenCourse getRequestOpenCourseDetail(long requestId);
    RequestOpenCourse getRequestOpenCourseDetailToUpdate(long roc_id,String lec_id);
    void deleteRequestOpenCourse(long requestId,String lec_id);
    List<Major> getMajor();
    void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse);
    void updateRequestOpenCourse(RequestOpenCourse requestOpenCourse);
    int getSignatureCourseMaxId();

    int getRequestCourseRoundMaxId(String course_id);
    List<Register> checkRegisterToDelete(long request_id);
    List<RequestOpenCourse> checkRequestOpenCourseByCourseIdToUnApprove(String course_id);

    List<RequestOpenCourse> getRequestOpenCoursesByLecturerIdAndStatus(String lec_id);
    List<Register> getRegistersByRocId(long request_id);
}
