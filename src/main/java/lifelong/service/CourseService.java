package lifelong.service;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;
public interface CourseService {
        List<Course> getCourses();
        Course getCourseDetail(String courseId);
        Course getCourseById(String course_id);

        List<Course> getCoursesByName (String courseName);
        String[] getCourseDetailOpject(String courseId);
        void doAddCourse(Course course);

        public void doAddMajor(Major major);
        void updateCourse(Course course);
}
