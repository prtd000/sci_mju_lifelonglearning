package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Queue;
@Repository
public class RequestOpenCourseDaoImpl implements RequestOpenCourseDao{

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(requestOpenCourse);
    }
}
