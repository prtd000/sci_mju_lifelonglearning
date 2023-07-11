package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Member;
import lifelong.model.Register;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
    public Member getMemberById(String memberId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Member> query = session.createQuery("FROM Member m WHERE m.id =: mId", Member.class);
        query.setParameter("mId", memberId);
        return query.getSingleResult();
    }

    @Override
    public List<Register> getListCourse(String memid) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register rg join RequestOpenCourse rq on rq.request_id = rg.requestOpenCourse.id join Course c on c.course_id = rq.course.id where rg.member.id =: mId");
        query.setParameter("mId",memid);
        List<Register> courses = query.getResultList();
        System.out.println("My list Course : " + courses.size());
        System.out.println(courses);
        return courses;
    }

}
