package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Invoice;
import lifelong.model.Member;
import lifelong.model.Register;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@Repository
public class MemberDaoImpl implements MemberDao{

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void registerCourse(Register register) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(register);
    }

    @Override
    public void doRegisterMember(Member member) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(member);
    }


    @Override
    public Member getMemberById(String memberId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Member> query = session.createQuery("FROM Member m WHERE m.id =: mId", Member.class);
        query.setParameter("mId", memberId);
        return query.getSingleResult();
    }

    @Override
    public List<Register> getMyListCourse(String memId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.member.id =: mId",Register.class);
        query.setParameter("mId",memId);
        List<Register> list = query.getResultList();
        return list;
    }

    @Override
    public List<Invoice> getListInvoice() {
        try {
            Session session = sessionFactory.getCurrentSession();
            Query<Invoice> query = session.createQuery("from Invoice",Invoice.class);
            List<Invoice> list = query.getResultList();
            System.out.println("Size : " + list);
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
