package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Invoice;
import lifelong.model.Register;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class RegisterDaoImpl implements RegisterDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveRegister(Register register) {
        Session session = sessionFactory.getCurrentSession();
        session.save(register);
    }

    @Override
    public void doInvoice(Invoice invoice) {
        Session session = sessionFactory.getCurrentSession();
        session.save(invoice);
    }

    @Override
    public Register getLastRow() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Register ORDER BY register_id DESC", Register.class);
        query.setMaxResults(1);
        return (Register) query.uniqueResult();
    }

}
