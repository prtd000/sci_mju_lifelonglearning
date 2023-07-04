package lifelong.dao;

import lifelong.model.Register;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RegisterDaoImpl implements RegisterDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveRegister(Register register) {
        Session session = sessionFactory.getCurrentSession();
        session.save(register);
    }
}
