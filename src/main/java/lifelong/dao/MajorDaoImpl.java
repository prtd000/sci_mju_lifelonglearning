package lifelong.dao;

import lifelong.model.Major;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


import java.util.List;
@Repository
public class MajorDaoImpl implements MajorDao{
    @Autowired
    SessionFactory sessionFactory;
    @Override
    public List<Major> getMajors() {
        Session session = sessionFactory.getCurrentSession();
        Query<Major> query = session.createQuery("from Major ", Major.class);
        List<Major> majors = query.getResultList();
        return majors;
    }
}
