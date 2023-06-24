package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class RequestOpCourseDaoImpl implements RequestOpCourseDao {
    @Autowired
    SessionFactory sessionFactory;
    @Override
    public List<Lecturer> getLecturer() {
        Session session = sessionFactory.getCurrentSession();
        Query<Lecturer> query = session.createQuery("from Lecturer ", Lecturer.class);
        List<Lecturer> lecturers = query.getResultList();
        return lecturers;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCourses() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse ", RequestOpenCourse.class);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public RequestOpenCourse getRequestOpenCourseDetail(String id) {
        Session session = sessionFactory.getCurrentSession();
        RequestOpenCourse requestOpenCourse = session.get(RequestOpenCourse.class, id);
        return requestOpenCourse;
    }

    @Override
    public void deleteRequestOpenCourse(String id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from RequestOpenCourse where id=:request_id");
        query.setParameter("request_id", id);
        query.executeUpdate();
    }

    @Override
    public List<Major> getMajors() {
        Session session = sessionFactory.getCurrentSession();
        org.hibernate.Query<Major> query = session.createQuery("from Major ",Major.class);
        List<Major> majors = query.getResultList();
        return majors;
    }

    @Override
    public void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(requestOpenCourse);
    }
}
