package lifelong.dao;

import lifelong.model.AddImg;
import lifelong.model.Course;
import lifelong.model.Major;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CourseDaoImpl implements CourseDao {
    @Autowired
    private SessionFactory sessionFactory;
    @Override
    public List<Course> getCourses() {
        Session session = sessionFactory.getCurrentSession();
        Query<Course> query = session.createQuery("from Course ",Course.class);
        List<Course> courses = query.getResultList();
        return courses;
    }

    @Override
    public List<AddImg> getAddImg() {
        Session session = sessionFactory.getCurrentSession();
        Query<AddImg> query = session.createQuery("from AddImg ",AddImg.class);
        List<AddImg> addImgs = query.getResultList();
        return addImgs;
    }

    @Override
    public Course getCourseDetail(String id) {
        Session session = sessionFactory.getCurrentSession();
        Course course = session.get(Course.class, id);
        return course;
    }

    @Override
    public int getLatestFileCount() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT MAX(id) FROM AddImg", Long.class);
        Long result = query.uniqueResult();
        return result != null ? result.intValue() : 0; // ถ้าไม่พบข้อมูลให้ส่งค่า 0 แทน
    }



    @Override
    public Course getCourseById(String course_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Course> query = session.createQuery("FROM Course c WHERE c.course_id =: cId", Course.class);
        query.setParameter("cId", course_id);
        Course course = query.getSingleResult();
        return course;
    }

    @Override
    public String[] getCourseDetailObject(String id) {
        Session session = sessionFactory.getCurrentSession();
        Course course = session.get(Course.class, id);
        String object = course.getObject();
        String[] parts = object.split("2");
        return parts;
    }

    @Override
    public List<Course> getCoursesByName(String courseName) {
        Session session = sessionFactory.getCurrentSession();
        Query<Course> query = session.createQuery("FROM Course c WHERE c.major.name =: cN", Course.class);
        query.setParameter("cN", courseName);
        System.out.println("FOUND : " + query.getResultList().size());
        System.out.println("FOUND : " + query.getResultList());
        return query.getResultList();
    }

    @Override
    public void doAddCourse(Course course) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(course);
    }

    @Override
    public void doAddMajor(Major major) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(major);
    }

    @Override
    public void doAddImg(AddImg addImg) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(addImg);
    }

//    @Override
//    public Course getCourse(String courseId) {
//        Session session = sessionFactory.getCurrentSession();
//        Course course = session.get(Course.class, courseId);
//        return course;
//    }

    @Override
    public Course updateCourse(Course course) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(course);
        return course;
    }
}
