package lifelong.dao;

import lifelong.model.AddImg;
import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;


public interface CourseDao {
    List<Course> getCourses();

    List<RequestOpenCourse> getListRequestOpCourse();
    List<AddImg> getAddImg();
    Course getCourseDetail(String id);

    int getLatestFileCount();
    Course getCourseById(String course_id);
    String[] getCourseDetailObject(String id);
    List<Course> getCoursesByName (String courseName);
    void doAddCourse(Course course);
    void doAddMajor(Major major);
    void doAddImg(AddImg addImg);
    Course updateCourse (Course course) ;
}

