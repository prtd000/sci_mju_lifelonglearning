package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;


public interface CourseDao {
    List<Course> getCourses();
//    List<Course> getCoursesAndRequests();

    List<Course> getCoursesByCourseStatus(String major);

    List<Course> getListCoursesOrderByDate();

    List<Course> getCoursesByCourseStatusAndType(String major, String type);

    List<Course> getCourseByStatus(String status);

    List<RequestOpenCourse> getListRequestOpCourse();

    List<RequestOpenCourse> getAllListRequestCourse();

    Course getCourseDetail(String id);

    Course getCourseById(String course_id);
    String[] getCourseDetailObject(String id);
    List<Course> getCoursesByName (String courseName);
    void doAddCourse(Course course);
    void doAddMajor(Major major);
    Course updateCourse (Course course) ;
    int getCourseMaxId(String course_type);

    int getImgCourseMaxId(String course_type);
    int getCoursePDFMaxId();
}

