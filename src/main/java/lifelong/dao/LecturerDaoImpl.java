package lifelong.dao;

import lifelong.model.Lecturer;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LecturerDaoImpl implements LecturerDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<Lecturer> getAllLecturers() {
        return null;
    }

    @Override
    public Lecturer getLecturerById(String lecturerId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Lecturer> query = session.createQuery("FROM Lecturer l WHERE l.username =: lUser", Lecturer.class);
        query.setParameter("lUser", lecturerId);
        return query.getSingleResult();
    }

    @Override
    public void addLecturer(Lecturer lecturer) {

    }

    @Override
    public void updateLecturer(Lecturer lecturer) {

    }

    @Override
    public void deleteLecturer(String lecturerId) {

    }
}
