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
    private CourseDao courseDao;
    @Override
    @Transactional
    public List<Course> getCourses() {
        return courseDao.getCourses();
    }

//    @Override
//    @Transactional
//    public List<Object[]> getCoursesAndRequests() {
//        return courseDao.getCoursesAndRequests();
//    }

    @Override
    @Transactional
    public List<Course> getCoursesByCourseStatus() {
        return courseDao.getCoursesByCourseStatus();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getListRequestOpCourse() {
        return courseDao.getListRequestOpCourse();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getAllListRequestCourse() {
        return courseDao.getAllListRequestCourse();
    }

    @Override
    @Transactional
    public List<AddImg> getAddImg() {
        return courseDao.getAddImg();
    }

    @Override
    @Transactional
    public AddImg getPdfById(long id) {
        return courseDao.getPdfById(id);
    }

    @Override
    @Transactional
    public void updatePDF(AddImg addImg) {
        courseDao.updatePDF(addImg);
    }

    @Override
    @Transactional
    public Course getCourseDetail(String courseId) {
        return courseDao.getCourseDetail(courseId);
    }

    @Override
    @Transactional
    public Course getCourseById(String course_id) {
        return courseDao.getCourseById(course_id);
    }

    @Override
    @Transactional
    public List<Course> getCoursesByName(String courseName) {
        return courseDao.getCoursesByName(courseName);
    }

    @Override
    @Transactional
    public String[] getCourseDetailObject(String courseId) {
        return courseDao.getCourseDetailObject(courseId);
    }

    @Override
    @Transactional
    public void doAddCourse(Course course) {
        String course_type = course.getCourse_type();
        long id = courseDao.getCourseMaxId(course_type);
        course.setCourse_id(generateMacCourseId(id + 1,course_type));
        courseDao.doAddCourse(course);
    }

    @Override
    @Transactional
    public void doAddImg(AddImg addImg) {
        courseDao.doAddImg(addImg);
    }

    @Override
    @Transactional
    public void doAddMajor(Major major) {
        courseDao.doAddMajor(major);
    }

    @Override
    @Transactional
    public void updateCourse(Course course) {
        courseDao.updateCourse(course);
    }

    @Override
    @Transactional
    public int getLatestFileCount() {
        return courseDao.getLatestFileCount();
    }

    @Override
    @Transactional
    public int getImgCourseMaxId(String course_type) {
        return courseDao.getImgCourseMaxId(course_type);
    }

    @Override
    @Transactional
    public int getCoursePDFMaxId() {
        return courseDao.getCoursePDFMaxId();
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
