package lifelong.service;

import lifelong.dao.RequestOpCourseDao;
import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RequestOpCourseServiceImpl implements RequestOpCourseService {
    @Autowired
    private RequestOpCourseDao requestOpCourseDao;

    @Override
    @Transactional
    public List<Lecturer> getLecturer() {
        return requestOpCourseDao.getLecturer();
    }

    @Override
    @Transactional
    public Lecturer getLecturerDetail(String lecUser) {
        return requestOpCourseDao.getLecturerDetail(lecUser);
    }

    @Override
    @Transactional
    public void saveRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        requestOpCourseDao.saveRequestOpenCourse(requestOpenCourse);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCourses() {
        return requestOpCourseDao.getRequestOpenCourses();
    }

    @Override
    @Transactional
    public RequestOpenCourse getRequestOpenCourseDetail(long requestId) {
        return requestOpCourseDao.getRequestOpenCourseDetail(requestId);
    }

    @Override
    @Transactional
    public void deleteRequestOpenCourse(long requestId) {
        requestOpCourseDao.deleteRequestOpenCourse(requestId);
    }

    @Override
    @Transactional
    public List<Major> getMajor() {
        return requestOpCourseDao.getMajors();
    }
    @Override
    @Transactional
    public void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse) {
        requestOpCourseDao.doRequestOpenCourseDetail(requestOpenCourse);
    }
//    @Override
//    @Transactional
//    public void saveProduct(Product product) {
//        long id = productDao.getLatestId();
//        product.setProductId(generateLatestId(id + 1));
//        productDao.saveProduct(product);
//    }

    @Override
    @Transactional
    public void updateRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        requestOpCourseDao.updateRequestOpenCourse(requestOpenCourse);
    }
    public String generateLatestId (long id) {
        String result = String.valueOf(id);
        while (result.length() != 3) {
            result = "0" + result;
        }
        return "PD" + result;
    }
}
