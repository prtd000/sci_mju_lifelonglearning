package lifelong.service;

import lifelong.model.*;

import java.util.List;
public interface CourseService {
        List<Course> getCourses();
//        List<Object[]> getCoursesAndRequests();
        List<Course> getCoursesByCourseStatus(String major);


        List<Course> getListCoursesOrderByDate();

        List<Course> getCoursesByCourseStatusAndType(String major,String type);

        List<RequestOpenCourse> getListRequestOpCourse();

        List<RequestOpenCourse> getAllListRequestCourse();

        Course getCourseDetail(String courseId);
        Course getCourseById(String course_id);

        List<Course> getCoursesByName (String courseName);
        String[] getCourseDetailObject(String courseId);
        void doAddCourse(Course course);

        List<Course> getCourseByStatus(String status);

        public void doAddMajor(Major major);
        void updateCourse(Course course);


        int getImgCourseMaxId(String course_type);

        int getCoursePDFMaxId();
}
