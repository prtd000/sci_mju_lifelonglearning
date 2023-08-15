package lifelong.dao;

import lifelong.model.*;
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
    public Lecturer getLecturerDetail(String id) {
        Session session = sessionFactory.getCurrentSession();
        Lecturer lecturer = session.get(Lecturer.class, id);
        return lecturer;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCourses() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse ", RequestOpenCourse.class);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }
    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.lecturer.id =: Id ", RequestOpenCourse.class);
        query.setParameter("Id",lec_id);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }
    @Override
    public RequestOpenCourse getRequestOpenCourseDetail(long id) {
        Session session = sessionFactory.getCurrentSession();
        RequestOpenCourse requestOpenCourse = session.get(RequestOpenCourse.class, id);
        return requestOpenCourse;
    }

    @Override
    public void saveRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        Session session = sessionFactory.getCurrentSession();
        session.save(requestOpenCourse);
    }

    @Override
    public void deleteRequestOpenCourse(long id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from RequestOpenCourse where id=:request_id");
        query.setParameter("request_id", id);
        query.executeUpdate();
    }

    @Override
    public RequestOpenCourse updateRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(requestOpenCourse);
        return requestOpenCourse;
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
    @Override
    public long getLatestId() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(rq) FROM RequestOpenCourse rq", Long.class);
        return query.getSingleResult();
    }
}
