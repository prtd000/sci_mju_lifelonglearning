package lifelong.service;

import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;

import java.util.List;
public interface CourseService {
        List<Course> getCourses();
        Course getCourseDetail(String courseId);

        List<Course> getCoursesByName (String courseName);
        String[] getCourseDetailOpject(String courseId);
        public void doAddCourse(Course course);

        public void doAddMajor(Major major);
}
