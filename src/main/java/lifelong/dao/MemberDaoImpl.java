package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Register;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDaoImpl implements MemberDao{

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public void registerCourse(Register register) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(register);
    }

}
