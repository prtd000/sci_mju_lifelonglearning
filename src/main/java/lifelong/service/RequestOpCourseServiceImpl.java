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
    public RequestOpenCourse getRequestOpCourseByCourseId(String courseId) {
        return requestOpCourseDao.getRequestOpCourseByCourseId(courseId);
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
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeRegister() {
        return requestOpCourseDao.getRequestOpenCoursesByTypeRegister();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeMaxRegister() {
        return requestOpCourseDao.getRequestOpenCoursesByTypeMaxRegister();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesByTypePayment() {
        return requestOpCourseDao.getRequestOpenCoursesByTypePayment();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeStudy() {
        return requestOpCourseDao.getRequestOpenCoursesByTypeStudy();
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
    public void checkDeleteRequestOpenCourse(long id) {
        requestOpCourseDao.checkDeleteRequestOpenCourse(id);
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
    public List<RequestOpenCourse> getRequestOpenCoursesByLecturerIdAndStatus(String lec_id) {
        return requestOpCourseDao.getRequestOpenCoursesByLecturerIdAndStatus(lec_id);
    }

    @Override
    @Transactional
    public List<Register> getRegistersByRocId(long request_id) {
        return requestOpCourseDao.getRegistersByRocId(request_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestCourseByStatus(String status, String lec_id) {
        return requestOpCourseDao.getRequestCourseByStatus(status,lec_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestCourseByTwoStatus(String status1, String status2, String lec_id) {
        return requestOpCourseDao.getRequestCourseByTwoStatus(status1,status2,lec_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestCourseByStatusByRegister(String status1, String status2, String status3, String status4, String lec_id) {
        return requestOpCourseDao.getRequestCourseByStatusByRegister(status1,status2,status3,status4,lec_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getAllRequestByStatusByRegister() {
        return requestOpCourseDao.getAllRequestByStatusByRegister();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getNoMaxRequestByStatusByRegister() {
        return requestOpCourseDao.getNoMaxRequestByStatusByRegister();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRegisAndPayRequestByStatusByRegister() {
        return requestOpCourseDao.getRegisAndPayRequestByStatusByRegister();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getPayRequestByStatusByRegister() {
        return requestOpCourseDao.getPayRequestByStatusByRegister();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getAllRequestByStatusByMaxRegister() {
        return requestOpCourseDao.getAllRequestByStatusByMaxRegister();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getAppRequestByStatusByRegister() {
        return requestOpCourseDao.getAppRequestByStatusByRegister();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getAllRequestByStatusByStudy() {
        return requestOpCourseDao.getAllRequestByStatusByStudy();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getAllCancelRequestByStatus() {
        return requestOpCourseDao.getAllCancelRequestByStatus();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getAllRequestBeforeApprove() {
        return requestOpCourseDao.getAllRequestBeforeApprove();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getAllRequestByStatusByFinishStudy() {
        return requestOpCourseDao.getAllRequestByStatusByFinishStudy();
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_Id) {
        return requestOpCourseDao.getRequestOpenCoursesByLecturerId(lec_Id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesByTypePaymentByLec(String lec_id) {
        return requestOpCourseDao.getRequestOpenCoursesByTypePaymentByLec(lec_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeApplicationByLec(String lec_id) {
        return requestOpCourseDao.getRequestOpenCoursesByTypeApplicationByLec(lec_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeStudyByLec(String lec_id) {
        return requestOpCourseDao.getRequestOpenCoursesByTypeStudyByLec(lec_id);
    }

    @Override
    @Transactional
    public List<RequestOpenCourse> getRequestOpenCoursesToCheckDateStudy(String lec_id) {
        return requestOpCourseDao.getRequestOpenCoursesToCheckDateStudy(lec_id);
    }

    public String generateLatestId (long id) {
        String result = String.valueOf(id);
        while (result.length() != 3) {
            result = "0" + result;
        }
        return "PD" + result;
    }
}
