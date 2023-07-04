package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface RequestOpCourseDao {
    List<Lecturer> getLecturer();

    List<RequestOpenCourse> getRequestOpenCourses();
    RequestOpenCourse getRequestOpenCourseDetail(long id);

    void deleteRequestOpenCourse(String id);

    List<Major> getMajors();
    void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse);

}
