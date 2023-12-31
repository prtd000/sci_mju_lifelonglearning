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
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Objects;

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
        Query<Activity> query = session.createQuery("from Activity a where a.type =:acType ORDER BY a.date DESC",Activity.class);
        query.setParameter("acType", "ข่าวสารทั่วไป");
        List<Activity> activities = query.getResultList();
        return activities;
    }

    @Override
    public List<Activity> getPublicActivityLast3Months() {
        Session session = sessionFactory.getCurrentSession();
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, -3); // ลดเวลากลับ 3 เดือน

        Query<Activity> query = session.createQuery("from Activity a where a.type =:acType AND a.date BETWEEN :startDate AND :endDate ORDER BY a.date DESC", Activity.class);
        query.setParameter("acType", "ข่าวสารทั่วไป");
        query.setParameter("startDate", calendar.getTime());
        query.setParameter("endDate", new Date()); // วันปัจจุบัน

        List<Activity> activities = query.getResultList();
        return activities;
    }

    @Override
    public List<Activity> getPrivateActivity() {
        Session session = sessionFactory.getCurrentSession();
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, -3); // ลดเวลากลับ 3 เดือน

        Query<Activity> query = session.createQuery("from Activity a WHERE a.type =: acType AND a.date BETWEEN :startDate AND :endDate ORDER BY a.date DESC",Activity.class);
        query.setParameter("acType", "ข่าวสารประจำหลักสูตร");
        query.setParameter("startDate", calendar.getTime());
        query.setParameter("endDate", new Date()); // วันปัจจุบัน
        return query.getResultList();
    }

    @Override
    public List<Activity> getViewCourseActivityNews(long req_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Activity> query = session.createQuery("FROM Activity a WHERE a.type =: acType AND a.requestOpenCourse.request_id =: reqId AND a.date >= :threeMonthsAgo ORDER BY a.date DESC", Activity.class);
        query.setParameter("acType", "ข่าวสารประจำหลักสูตร");
        query.setParameter("reqId", req_id);

        // คำนวณวันที่ก่อน 3 เดือนจากวันปัจจุบัน
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, -3);
        Date threeMonthsAgo = calendar.getTime();

        query.setParameter("threeMonthsAgo", threeMonthsAgo);

        List<Activity> activities = query.getResultList();
        return activities;
    }

    @Override
    public Activity getActivityDetail(String id) {
        Session session = sessionFactory.getCurrentSession();
        Activity activity = session.get(Activity.class, id);
        return activity;
    }
    @Override
    public Activity getActivityDetailToUpdate(String id , String lec_id) {
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
        Query<Activity> query = session.createQuery("FROM Activity a WHERE a.requestOpenCourse.id =: roc_Id ORDER BY a.date DESC", Activity.class);
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
    public void deleteActivity(String id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Activity where id=:ac_id");
        query.setParameter("ac_id", id);
        query.executeUpdate();
    }
    @Override
    public int getLatestActivityCount() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT MAX(id) FROM Activity ", Long.class);
        Long result = query.uniqueResult();
        return result != null ? result.intValue() : 0; // ถ้าไม่พบข้อมูลให้ส่งค่า 0 แทน
    }
    @Override
    public void deleteCourseActivity(String id , String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Activity where id=:ac_id and lecturer.username = : lec_id");
        query.setParameter("ac_id", id);
        query.setParameter("lec_id", lec_id);
        query.executeUpdate();
    }
    @Override
    public int getActivityMaxId(String activity_type) {
        Session session = sessionFactory.getCurrentSession();
        Query<String> query;
        if (Objects.equals(activity_type, "ข่าวสารทั่วไป")) {
            // ดึงค่ามากสุดที่มีตัวอักษรเริ่มต้นด้วย "AP"
            query = session.createQuery(
                    "SELECT MAX(a.ac_id) FROM Activity a " +
                            "WHERE a.ac_id LIKE 'AP%'",
                    String.class
            );
        } else {
            // ดึงค่ามากสุดที่มีตัวอักษรเริ่มต้นด้วย "AC"
            query = session.createQuery(
                    "SELECT MAX(a.ac_id) FROM Activity a " +
                            "WHERE a.ac_id LIKE 'AC%'",
                    String.class
            );
        }
        String maxString = query.getSingleResult();

        if (maxString != null && maxString.length() > 1) {
            // ตัดส่วน AP กับ AC ออก
            maxString = maxString.replace("AP", "").replace("AC", "");
            int maxNumericId = Integer.parseInt(maxString);
            return maxNumericId;
        } else {
            // หากไม่สามารถดึงค่าได้หรือค่ามีความยาวน้อยกว่า 2 จะคืนค่าเริ่มต้นหรือค่าที่เหมาะสม
            return 0; // เปลี่ยนตามความเหมาะสม
        }
    }
}
