package lifelong.service;

import lifelong.model.*;

import java.util.List;
public interface CourseService {
        List<Course> getCourses();

        List<RequestOpenCourse> getListRequestOpCourse();
        List<AddImg> getAddImg();
        Course getCourseDetail(String courseId);
        Course getCourseById(String course_id);

        List<Course> getCoursesByName (String courseName);
        String[] getCourseDetailObject(String courseId);
        void doAddCourse(Course course);

        void doAddImg(AddImg addImg);

        public void doAddMajor(Major major);
        void updateCourse(Course course);

        int getLatestFileCount();
        int getImgCourseMaxId(String course_type);
}
