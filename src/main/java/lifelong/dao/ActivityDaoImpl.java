package lifelong.dao;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}
