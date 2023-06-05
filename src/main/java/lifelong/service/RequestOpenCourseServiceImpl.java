package lifelong.service;

import lifelong.dao.RequestOpenCourseDao;
import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
public class RequestOpenCourseServiceImpl implements RequestOpenCourseService{
    @Autowired
    private RequestOpenCourseDao requestOpenCourseDao;

    @Override
    @Transactional
    public void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse) {
        requestOpenCourseDao.doRequestOpenCourseDetail(requestOpenCourse);
    }
}
