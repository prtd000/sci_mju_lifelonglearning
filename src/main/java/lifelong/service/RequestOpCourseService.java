package lifelong.service;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface RequestOpCourseService {
    List<Lecturer> getLecturer();

    List<RequestOpenCourse> getRequestOpenCourses();

    RequestOpenCourse getRequestOpenCourseDetail(String requestId);
    void deleteRequestOpenCourse(String requestId);
    List<Major> getMajor();
    public void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse);
    void updateRequestOpenCourse(RequestOpenCourse productEntity, RequestOpenCourse requestOpenCourse);
}
