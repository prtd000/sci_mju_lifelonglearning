package lifelong.service;

import lifelong.dao.RequestOpCourseDao;
import lifelong.model.*;
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
    public RequestOpenCourse getRequestOpenCourseDetailToUpdate(long roc_id,String lec_id) {
        return requestOpCourseDao.getRequestOpenCourseDetailToUpdate(roc_id,lec_id);
    }

    @Override
    @Transactional
    public void deleteRequestOpenCourse(long requestId,String lec_id) {
        requestOpCourseDao.deleteRequestOpenCourse(requestId,lec_id);
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

    @Override
    @Transactional
    public int getSignatureCourseMaxId() {
        return requestOpCourseDao.getSignatureCourseMaxId();
    }

    @Override
    @Transactional
    public int getRequestCourseRoundMaxId(String course_id) {
        return requestOpCourseDao.getRequestCourseRoundMaxId(course_id);
    }

    @Override
    @Transactional
    public List<Register> checkRegisterToDelete(long request_id) {
        return requestOpCourseDao.checkRegisterToDelete(request_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> checkRequestOpenCourseByCourseIdToUnApprove(String course_id) {
        return requestOpCourseDao.checkRequestOpenCourseByCourseIdToUnApprove(course_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_Id) {
        return requestOpCourseDao.getRequestOpenCoursesByLecturerId(lec_Id);
    }
    public String generateLatestId (long id) {
        String result = String.valueOf(id);
        while (result.length() != 3) {
            result = "0" + result;
        }
        return "PD" + result;
    }
}
