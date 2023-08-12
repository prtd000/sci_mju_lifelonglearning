package lifelong.service;

import lifelong.dao.CourseDao;
import lifelong.model.Course;
import lifelong.model.Major;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CourseServiceImpl implements CourseService{

    @Autowired
    private CourseDao couresDao;
    @Override
    @Transactional
    public List<Course> getCourses() {
        return couresDao.getCourses();
    }

    @Override
    @Transactional
    public Course getCourseDetail(String courseId) {
        return couresDao.getCourseDetail(courseId);
    }

    @Override
    @Transactional
    public Course getCourseById(String course_id) {
        return couresDao.getCourseById(course_id);
    }

    @Override
    @Transactional
    public List<Course> getCoursesByName(String courseName) {
        return couresDao.getCoursesByName(courseName);
    }

    @Override
    @Transactional
    public String[] getCourseDetailObject(String courseId) {
        return couresDao.getCourseDetailObject(courseId);
    }

    @Override
    @Transactional
    public void doAddCourse(Course course) {
        couresDao.doAddCourse(course);
    }
    @Override
    @Transactional
    public void doAddMajor(Major major) {
        couresDao.doAddMajor(major);
    }

    @Override
    @Transactional
    public void updateCourse(Course course) {
        couresDao.updateCourse(course);
    }
}
