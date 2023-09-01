package lifelong.dao;

import lifelong.model.AddImg;
import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;


public interface CourseDao {
    List<Course> getCourses();
//    List<Course> getCoursesAndRequests();

    List<Course> getCoursesByCourseStatus();

    List<RequestOpenCourse> getListRequestOpCourse();
    List<AddImg> getAddImg();

    AddImg getPdfById(long id);
    AddImg updatePDF (AddImg addImg) ;

    Course getCourseDetail(String id);

    int getLatestFileCount();
    Course getCourseById(String course_id);
    String[] getCourseDetailObject(String id);
    List<Course> getCoursesByName (String courseName);
    void doAddCourse(Course course);
    void doAddMajor(Major major);
    void doAddImg(AddImg addImg);
    Course updateCourse (Course course) ;
    int getCourseMaxId(String course_type);

    int getImgCourseMaxId(String course_type);
    int getCoursePDFMaxId();
}

