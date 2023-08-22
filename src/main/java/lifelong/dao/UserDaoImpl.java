package lifelong.dao;

import lifelong.model.Admin;
import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Member;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDaoImpl implements UserDao{

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Member getMemberByUsername(String id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Member> query = session.createQuery("FROM Member m WHERE m.username =: userName", Member.class);
        query.setParameter("userName", id);
        Member member = new Member();
        try {
            member = query.getSingleResult();
        }catch (Exception e){

        }
        return member;
    }

    @Override
    public Lecturer getLecturerByUsername(String id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Lecturer> query = session.createQuery("FROM Lecturer l WHERE l.username =: userName", Lecturer.class);
        query.setParameter("userName", id);
        Lecturer lecturer = new Lecturer();
        try {
            lecturer = query.getSingleResult();
        }catch (Exception e){

        }
        return lecturer;
    }

    @Override
    public Admin getAdminByUsername(String id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Admin> query = session.createQuery("FROM Admin a WHERE a.username =: userName", Admin.class);
        query.setParameter("userName", id);
        Admin admin = new Admin();
        try {
            admin = query.getSingleResult();
        } catch (Exception e) {

        }
        return admin;
    }

    @Override
    public List<Member> getUsernames() {
        Session session = sessionFactory.getCurrentSession();
        Query<Member> query = session.createQuery("from Member ",Member.class);
        List<Member> members = query.getResultList();
        return members;
    }
}
