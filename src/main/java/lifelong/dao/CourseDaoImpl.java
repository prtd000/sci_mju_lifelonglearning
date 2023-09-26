package lifelong.dao;

import lifelong.model.AddImg;
import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Objects;

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

//    @Override
//    public List<Course> getCoursesByRequest() {
//        Session session = sessionFactory.getCurrentSession();
//        Query<Course> query = session.createQuery("from Course c join RequestOpenCourse roc on c.id = roc.course.id ",Course.class);
//        List<Course> courses = query.getResultList();
//        return courses;
//    }

    @Override
    public List<Course> getCoursesByCourseStatus() {
        Session session = sessionFactory.getCurrentSession();
        Query<Course> query = session.createQuery("from Course where status =: c_status",Course.class);
        query.setParameter("c_status", "ยังไม่เปิดสอน");
        return query.getResultList();
    }

    @Override
    public List<RequestOpenCourse> getListRequestOpCourse() {
        Session session = sessionFactory.getCurrentSession();
        String stt_pass = "ผ่าน";
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse rq where rq.requestStatus =: pass",RequestOpenCourse.class);
        query.setParameter("pass", stt_pass);
        List<RequestOpenCourse> list = query.getResultList();
        System.out.println("Request num of pass : " + list.size());
        return list;
    }

    @Override
    public List<RequestOpenCourse> getAllListRequestCourse() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse",RequestOpenCourse.class);
        return query.getResultList();
    }

    @Override
    public List<AddImg> getAddImg() {
        Session session = sessionFactory.getCurrentSession();
        Query<AddImg> query = session.createQuery("from AddImg ",AddImg.class);
        List<AddImg> addImgs = query.getResultList();
        return addImgs;
    }

    @Override
    public AddImg getPdfById(long id) {
        Session session = sessionFactory.getCurrentSession();
        AddImg addImg = session.get(AddImg.class, id);
        return addImg;
    }

    @Override
    public AddImg updatePDF(AddImg addImg) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(addImg);
        return addImg;
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
//    @Override
//    public String getCourseMaxId() {
//        Session session = sessionFactory.getCurrentSession();
//        Query<String> query = session.createQuery("SELECT MAX(id) FROM Course", String.class);
//        return query.getSingleResult();
//    }
@Override
public int getCourseMaxId(String course_type) {
    Session session = sessionFactory.getCurrentSession();
    Query<String> query;
    if (Objects.equals(course_type, "หลักสูตรอบรมระยะสั้น")) {
        // ดึงค่ามากสุดที่มีตัวอักษรเริ่มต้นด้วย "C"
        query = session.createQuery(
                "SELECT MAX(c.id) FROM Course c " +
                        "WHERE c.id LIKE 'C%'",
                String.class
        );
    } else {
        // ดึงค่ามากสุดที่มีตัวอักษรเริ่มต้นด้วย "P"
        query = session.createQuery(
                "SELECT MAX(c.id) FROM Course c " +
                        "WHERE c.id LIKE 'N%'",
                String.class
        );
    }
    String maxString = query.getSingleResult();

    if (maxString != null && maxString.length() > 1) {
        // ตัดอักษรแรกออกและแปลงเป็นตัวเลข
        int maxNumericId = Integer.parseInt(maxString.substring(1));
        return maxNumericId;
    } else {
        // หากไม่สามารถดึงค่าได้หรือค่ามีความยาวน้อยกว่า 2 จะคืนค่าเริ่มต้นหรือค่าที่เหมาะสม
        return 0; // เปลี่ยนตามความเหมาะสม
    }
}
    @Override
    public int getImgCourseMaxId(String course_type) {
        Session session = sessionFactory.getCurrentSession();
        Query<String> query;

        String imagePrefix = course_type.equals("หลักสูตรอบรมระยะสั้น") ? "C_IMG" : "N_IMG";

        query = session.createQuery(
                "SELECT MAX(c.img) FROM Course c " +
                        "WHERE c.img LIKE :imagePrefix",
                String.class
        );
        query.setParameter("imagePrefix", imagePrefix + "%");

        String maxString = query.getSingleResult();

        if (maxString != null && maxString.length() > imagePrefix.length()) {
            // ตัดส่วนของ "C_IMG" หรือ "N_IMG" และส่วนของไฟล์ภาพออก
            int dotIndex = maxString.lastIndexOf(".");
            if (dotIndex > 0) {
                maxString = maxString.substring(0, dotIndex); // ตัดส่วนนามสกุลออก
            }
            maxString = maxString.replace("C_IMG", "").replace("N_IMG", "");

            int maxNumericId = Integer.parseInt(maxString);
            return maxNumericId;
        } else {
            return 0;
        }
    }

    @Override
    public int getCoursePDFMaxId() {
        Session session = sessionFactory.getCurrentSession();
        Query<String> query;
            // ดึงค่ามากสุดที่มีตัวอักษรเริ่มต้นด้วย "C"
            query = session.createQuery(
                    "SELECT MAX(c.file) FROM Course c " +
                            "WHERE c.file LIKE 'PDF_%'",
                    String.class
            );
        String maxString = query.getSingleResult();

        String imagePrefix = "PDF_";
        if (maxString != null && maxString.length() > imagePrefix.length()) {
            // ตัดส่วนของ "PDF_" และส่วนของไฟล์ภาพออก
            int dotIndex = maxString.lastIndexOf(".");
            if (dotIndex > 0) {
                maxString = maxString.substring(0, dotIndex); // ตัดส่วนนามสกุลออก
            }
            maxString = maxString.replace("PDF_", "");

            int maxNumericId = Integer.parseInt(maxString);
            return maxNumericId;
        } else {
            return 0;
        }
    }


}
