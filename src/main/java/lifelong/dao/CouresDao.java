package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;


public interface CouresDao {
    List<Course> getCourses();
    Course getCourseDetail(String id);
    Course getCourseById(String course_id);
    String[] getCourseDetailOpject(String id);
    List<Course> getCoursesByName (String courseName);
    void doAddCourse(Course course);
    void doAddMajor(Major major);
}

