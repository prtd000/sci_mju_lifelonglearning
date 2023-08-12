package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Invoice;
import lifelong.model.Register;
import lifelong.model.RequestOpenCourse;
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
    public List<Register> getRegister(String memId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.member.id =: Id ", Register.class);
        query.setParameter("Id",memId);
        List<Register> registers = query.getResultList();
        for (Register r: registers) {
            System.out.println("registerId " + memId + " : " + r.getRegister_id());
        }
        return registers;
    }

    @Override
    public List<Register> getRegisterByRequestId(long roc_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id ", Register.class);
        query.setParameter("Id",roc_Id);
        List<Register> registers = query.getResultList();
        return registers;
    }
    @Override
    public List<Register> getRegisterByRequestIdAndPayStatus(long roc_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.id =: roc_Id AND r.invoice.pay_status = : pay_status", Register.class);
        query.setParameter("roc_Id",roc_Id);
        query.setParameter("pay_status",true);
        List<Register> registers = query.getResultList();
        return registers;
    }

    @Override
    public Register getRegisterById(String memId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("FROM Register r WHERE r.member.id =: memId", Register.class);
        query.setParameter("memId", memId);
        Register register = query.getSingleResult();
        return register;
    }
    @Override
    public Register getRegisterByRegisterId(long register_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("FROM Register r WHERE r.id =: memId", Register.class);
        query.setParameter("memId", register_Id);
        Register register = query.getSingleResult();
        return register;
    }
    @Override
    public void saveRegister(Register register) {
        Session session = sessionFactory.getCurrentSession();
        session.save(register);
    }

    @Override
    public void deleteRegister(long id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Register where id =: Id");
        query.setParameter("Id", id);
        query.executeUpdate();
    }

    @Override
    public void doInvoice(Invoice invoice) {
        Session session = sessionFactory.getCurrentSession();
        session.save(invoice);
    }

    @Override
    public void deleteInvoice(long register_id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Invoice i where i.register.register_id =: Id ");
        query.setParameter("Id",register_id);
        query.executeUpdate();
    }

    @Override
    public Register getLastRow() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Register r ORDER BY r.register_id DESC");
        query.setMaxResults(1);
        Register register = (Register) query.uniqueResult();
        return register;
    }
    @Override
    public Register updateRegister (Register register) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(register);
        return register;
    }
}
