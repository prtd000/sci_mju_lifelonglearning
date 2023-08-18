package lifelong.service;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface RequestOpCourseService {
    List<Lecturer> getLecturer();
    Lecturer getLecturerDetail(String lecUser);

    void saveRequestOpenCourse (RequestOpenCourse requestOpenCourse);
    List<RequestOpenCourse> getRequestOpenCourses();
    List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_id);
    RequestOpenCourse getRequestOpenCourseDetail(long requestId);
    RequestOpenCourse getRequestOpenCourseDetailToUpdate(long roc_id,String lec_id);
    void deleteRequestOpenCourse(long requestId,String lec_id);
    List<Major> getMajor();
    void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse);
    void updateRequestOpenCourse(RequestOpenCourse requestOpenCourse);
}
