package lifelong.dao;

import lifelong.model.Lecturer;
import lifelong.model.Major;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class LecturerDaoImpl implements LecturerDao{
    @Autowired
    SessionFactory sessionFactory;
    @Override
    public List<Lecturer> getLecturer() {
        Session session = sessionFactory.getCurrentSession();
        Query<Lecturer> query = session.createQuery("from Lecturer ", Lecturer.class);
        List<Lecturer> lecturers = query.getResultList();
        return lecturers;
    }
}
