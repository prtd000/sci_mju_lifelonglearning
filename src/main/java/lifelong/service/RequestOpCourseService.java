package lifelong.service;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface RequestOpCourseService {
    List<Lecturer> getLecturer();
    Lecturer getLecturerDetail(String lecUser);

    List<RequestOpenCourse> getRequestOpenCourses();

    RequestOpenCourse getRequestOpenCourseDetail(long requestId);
    void deleteRequestOpenCourse(String requestId);
    List<Major> getMajor();
    void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse);
    void updateRequestOpenCourse(RequestOpenCourse productEntity, RequestOpenCourse requestOpenCourse);
}
