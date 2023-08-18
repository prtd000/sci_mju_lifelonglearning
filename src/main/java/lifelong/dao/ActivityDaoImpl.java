package lifelong.dao;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.NoResultException;
import java.util.List;

@Repository
public class ActivityDaoImpl implements ActivityDao{
    @Autowired
    private SessionFactory sessionFactory;
    @Override
    public void addActivityNews(Activity activity) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(activity);
    }

    @Override
    public List<Activity> getPublicActivity() {
        Session session = sessionFactory.getCurrentSession();
        Query<Activity> query = session.createQuery("from Activity a where a.type =:acType",Activity.class);
        query.setParameter("acType", "Public");
        List<Activity> activities = query.getResultList();
        return activities;
    }

    @Override
    public Activity getActivityDetail(long id) {
        Session session = sessionFactory.getCurrentSession();
        Activity activity = session.get(Activity.class, id);
        return activity;
    }
    @Override
    public Activity getActivityDetailToUpdate(long id , String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Activity> query = session.createQuery("FROM Activity a WHERE a.ac_id =: ac_id and a.lecturer.username =: lec_id", Activity.class);
        query.setParameter("ac_id", id);
        query.setParameter("lec_id", lec_id);

        try {
            Activity activity = query.getSingleResult();
            System.out.println(activity);
            return activity;
        } catch (NoResultException e) {
            // ไม่พบข้อมูล ในกรณีนี้คุณสามารถจัดการตามที่คุณต้องการได้
            // เช่น คืนค่า null, คืนค่าว่าง, หรือส่งกลับข้อความบอกว่าไม่พบข้อมูล
            return null; // หรือ return ค่าที่คุณต้องการ
        }
    }

    @Override
    public List<Activity> getActivityByRequestOpenCourseId(long id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Activity> query = session.createQuery("FROM Activity a WHERE a.requestOpenCourse.id =: roc_Id", Activity.class);
        query.setParameter("roc_Id", id);
        List<Activity> activity = query.getResultList();
        return activity;
    }
    @Override
    public Activity updateActivity(Activity activity) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(activity);
        return activity;
    }

    @Override
    public void deleteActivity(long id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Activity where id=:ac_id");
        query.setParameter("ac_id", id);
        query.executeUpdate();
    }
    @Override
    public void deleteCourseActivity(long id , String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Activity where id=:ac_id and lecturer.username = : lec_id");
        query.setParameter("ac_id", id);
        query.setParameter("lec_id", lec_id);
        query.executeUpdate();
    }
}
