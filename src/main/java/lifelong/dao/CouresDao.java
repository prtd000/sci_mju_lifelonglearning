package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;


public interface CouresDao {
    List<Course> getCourses();
    Course getCourseDetail(String id);
    String[] getCourseDetailOpject(String id);
    void doAddCourse(Course course);
    void doAddMajor(Major major);
}

