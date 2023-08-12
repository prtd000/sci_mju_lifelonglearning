package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Major;

import java.util.List;


public interface CourseDao {
    List<Course> getCourses();
    Course getCourseDetail(String id);
    Course getCourseById(String course_id);
    String[] getCourseDetailObject(String id);
    List<Course> getCoursesByName (String courseName);
    void doAddCourse(Course course);
    void doAddMajor(Major major);

    Course updateCourse (Course course) ;
}

