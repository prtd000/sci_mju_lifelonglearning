package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface RequestOpCourseDao {
    List<Lecturer> getLecturer();
    Lecturer getLecturerDetail(String id);

    List<RequestOpenCourse> getRequestOpenCourses();
    List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_id);
    RequestOpenCourse getRequestOpenCourseDetail(long id);

    void saveRequestOpenCourse (RequestOpenCourse requestOpenCourse);
    void deleteRequestOpenCourse(long id);

    RequestOpenCourse updateRequestOpenCourse (RequestOpenCourse requestOpenCourse) ;

    List<Major> getMajors();
    void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse);

    long getLatestId();
}
