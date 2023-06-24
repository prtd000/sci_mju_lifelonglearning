package lifelong.service;

import lifelong.dao.RequestOpCourseDao;
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
    public List<RequestOpenCourse> getRequestOpenCourses() {
        return requestOpCourseDao.getRequestOpenCourses();
    }

    @Override
    @Transactional
    public RequestOpenCourse getRequestOpenCourseDetail(String requestId) {
        return requestOpCourseDao.getRequestOpenCourseDetail(requestId);
    }

    @Override
    @Transactional
    public void deleteRequestOpenCourse(String requestId) {
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
    @Override
    @Transactional
    public void updateRequestOpenCourse(RequestOpenCourse productEntity, RequestOpenCourse requestOpenCourse) {
        productEntity.fill(requestOpenCourse);
        doRequestOpenCourseDetail(productEntity);
    }
}
