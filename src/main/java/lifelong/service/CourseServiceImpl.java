package lifelong.service;

import lifelong.dao.CourseDao;
import lifelong.model.AddImg;
import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

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
    public List<RequestOpenCourse> getListRequestOpCourse() {
        return couresDao.getListRequestOpCourse();
    }

    @Override
    @Transactional
    public List<AddImg> getAddImg() {
        return couresDao.getAddImg();
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
        String course_type = course.getCourse_type();
        long id = couresDao.getCourseMaxId(course_type);
        course.setCourse_id(generateMacCourseId(id + 1,course_type));
        couresDao.doAddCourse(course);
    }

    @Override
    @Transactional
    public void doAddImg(AddImg addImg) {
        couresDao.doAddImg(addImg);
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

    @Override
    @Transactional
    public int getLatestFileCount() {
        return couresDao.getLatestFileCount();
    }

    @Override
    @Transactional
    public int getImgCourseMaxId(String course_type) {
        return couresDao.getImgCourseMaxId(course_type);
    }

    public String generateMacCourseId (long id,String course_type) {
        String result = String.valueOf(id);
        while (result.length() != 3) {
            result = "0" + result;
        }
        if (Objects.equals(course_type, "หลักสูตรอบรมระยะสั้น")){
            return "C" + result;
        }else {
            return "N" + result;
        }
    }
}
