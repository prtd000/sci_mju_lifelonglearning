package lifelong.dao;

import lifelong.model.Test_img;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestDaoImpl implements TestDao{
    @Autowired
    private SessionFactory sessionFactory;
    @Override
    public void doAddImg(Test_img testImg) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(testImg);
    }

    @Override
    public int max_id() {
        Session session = sessionFactory.getCurrentSession();
        Query<Integer> query = session.createQuery("SELECT MAX(id) FROM Test_img ", Integer.class);
        Integer result = query.uniqueResult();
        return result != null ? result.intValue() : 0; // ถ้าไม่พบข้อมูลให้ส่งค่า 0 แทน
    }
}
