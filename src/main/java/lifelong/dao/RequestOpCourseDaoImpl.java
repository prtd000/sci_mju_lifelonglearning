package lifelong.dao;

import lifelong.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.NoResultException;
import java.util.List;
import java.util.Objects;

@Repository
public class RequestOpCourseDaoImpl implements RequestOpCourseDao {
    @Autowired
    SessionFactory sessionFactory;
    @Override
    public List<Lecturer> getLecturer() {
        Session session = sessionFactory.getCurrentSession();
        Query<Lecturer> query = session.createQuery("from Lecturer ", Lecturer.class);
        List<Lecturer> lecturers = query.getResultList();
        return lecturers;
    }

    @Override
    public Lecturer getLecturerDetail(String id) {
        Session session = sessionFactory.getCurrentSession();
        Lecturer lecturer = session.get(Lecturer.class, id);
        return lecturer;
    }

    @Override
    public RequestOpenCourse getRequestOpCourseByCourseId(String courseId) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.course.id =: Id",RequestOpenCourse.class);
        query.setParameter("Id" ,courseId);
        return query.getSingleResult();
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCourses() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse ORDER BY requestDate DESC", RequestOpenCourse.class);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse ORDER BY endRegister asc", RequestOpenCourse.class);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeMaxRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse ORDER BY applicationResult ASC", RequestOpenCourse.class);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByTypePayment() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse ORDER BY endPayment ASC", RequestOpenCourse.class);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeStudy() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse ORDER BY endStudyDate ASC", RequestOpenCourse.class);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByLecturerId(String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.lecturer.id =: Id ORDER BY requestDate DESC", RequestOpenCourse.class);
        query.setParameter("Id",lec_id);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByTypePaymentByLec(String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.lecturer.id =: Id ORDER BY endPayment ASC", RequestOpenCourse.class);
        query.setParameter("Id",lec_id);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeApplicationByLec(String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.lecturer.id =: Id ORDER BY applicationResult ASC", RequestOpenCourse.class);
        query.setParameter("Id",lec_id);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByTypeStudyByLec(String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.lecturer.id =: Id ORDER BY endStudyDate ASC", RequestOpenCourse.class);
        query.setParameter("Id",lec_id);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesByLecturerIdAndStatus(String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.lecturer.id =: Id and r.requestStatus = 'รอดำเนินการ'", RequestOpenCourse.class);
        query.setParameter("Id",lec_id);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRequestOpenCoursesToCheckDateStudy(String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.lecturer.id = :Id " +
                "and r.requestStatus NOT IN ('เสร็จสิ้น', 'ถูกยกเลิก', 'ไม่ผ่าน')", RequestOpenCourse.class);
        query.setParameter("Id", lec_id);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public RequestOpenCourse getRequestOpenCourseDetail(long id) {
        Session session = sessionFactory.getCurrentSession();
        RequestOpenCourse requestOpenCourse = session.get(RequestOpenCourse.class, id);
        return requestOpenCourse;
    }

    @Override
    public List<RequestOpenCourse> checkRequestOpenCourseByCourseIdToUnApprove(String course_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse r where r.course.id =: Id "+
                "and r.round = 0 and r.requestStatus = 'รอดำเนินการ'", RequestOpenCourse.class);
        query.setParameter("Id",course_id);
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public RequestOpenCourse getRequestOpenCourseDetailToUpdate(long roc_id,String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("FROM RequestOpenCourse r WHERE r.id =: roc_id and r.lecturer.username =: lec_id", RequestOpenCourse.class);
        query.setParameter("roc_id", roc_id);
        query.setParameter("lec_id", lec_id);

        try {
            RequestOpenCourse requestOpenCourse = query.getSingleResult();
            System.out.println(requestOpenCourse);
            return requestOpenCourse;
        } catch (NoResultException e) {
            // ไม่พบข้อมูล ในกรณีนี้คุณสามารถจัดการตามที่คุณต้องการได้
            // เช่น คืนค่า null, คืนค่าว่าง, หรือส่งกลับข้อความบอกว่าไม่พบข้อมูล
            return null; // หรือ return ค่าที่คุณต้องการ
        }
    }
    @Override
    public void saveRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        Session session = sessionFactory.getCurrentSession();
        session.save(requestOpenCourse);
    }

    @Override
    public void deleteRequestOpenCourse(long id,String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from RequestOpenCourse where id=:request_id and lecturer.username =: lec_id");
        query.setParameter("request_id", id);
        query.setParameter("lec_id", lec_id);
        query.executeUpdate();
    }

    @Override
    public void checkDeleteRequestOpenCourse(long id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from RequestOpenCourse where id=:request_id");
        query.setParameter("request_id", id);
        query.executeUpdate();
    }

    @Override
    public RequestOpenCourse updateRequestOpenCourse(RequestOpenCourse requestOpenCourse) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(requestOpenCourse);
        return requestOpenCourse;
    }

    @Override
    public List<Major> getMajors() {
        Session session = sessionFactory.getCurrentSession();
        org.hibernate.Query<Major> query = session.createQuery("from Major ",Major.class);
        List<Major> majors = query.getResultList();
        return majors;
    }

    @Override
    public void doRequestOpenCourseDetail(RequestOpenCourse requestOpenCourse) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(requestOpenCourse);
    }
    @Override
    public long getLatestId() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(rq) FROM RequestOpenCourse rq", Long.class);
        return query.getSingleResult();
    }

    @Override
    public int getSignatureCourseMaxId() {
        Session session = sessionFactory.getCurrentSession();
        Query<String> query = session.createQuery(
                "SELECT MAX(re.signature) FROM RequestOpenCourse re " +
                        "WHERE re.signature LIKE 'SIG%'",
                String.class
        );
        String maxString = query.getSingleResult();

        if (maxString != null && maxString.length() > 1) {
            // ตัดส่วนของ "SIG" และส่วนของไฟล์ภาพออก
            int dotIndex = maxString.lastIndexOf(".");
            if (dotIndex > 0) {
                maxString = maxString.substring(0, dotIndex); // ตัดส่วนนามสกุลออก
            }
            maxString = maxString.replace("SIG", "");

            return Integer.parseInt(maxString);
        } else {
            // หากไม่สามารถดึงค่าได้หรือค่ามีความยาวน้อยกว่า 2 จะคืนค่าเริ่มต้นหรือค่าที่เหมาะสม
            return 0; // เปลี่ยนตามความเหมาะสม
        }
    }

    @Override
    public int getRequestCourseRoundMaxId(String course_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Integer> query = session.createQuery("SELECT MAX(re.round) FROM RequestOpenCourse re " +
                "where re.course.id=:cid ", Integer.class);
        query.setParameter("cid", course_id);
        return query.uniqueResult(); // ถ้าไม่พบข้อมูลให้ส่งค่า 0 แทน
    }

    @Override
    public List<Register> checkRegisterToDelete(long request_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("FROM Register r WHERE r.requestOpenCourse.id =: roc_id ", Register.class);
        query.setParameter("roc_id", request_id);

        try {
            List<Register> register = query.getResultList();
            System.out.println(register);
            return register;
        } catch (NoResultException e) {
            // ไม่พบข้อมูล ในกรณีนี้คุณสามารถจัดการตามที่คุณต้องการได้
            // เช่น คืนค่า null, คืนค่าว่าง, หรือส่งกลับข้อความบอกว่าไม่พบข้อมูล
            return null; // หรือ return ค่าที่คุณต้องการ
        }
    }

    @Override
    public List<Register> getRegistersByRocId(long request_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.request_id =: Id ", Register.class);
        query.setParameter("Id",request_id);
        List<Register> registers = query.getResultList();
        return registers;
    }

    @Override
    public List<RequestOpenCourse> getRequestCourseByStatus(String status,String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = null;
        if (Objects.equals(status, "ลงทะเบียน") || Objects.equals(status, "ลงทะเบียน/ชำระเงิน")){
            query = session.createQuery("from RequestOpenCourse where course.status =: c_status and lecturer.username =: c_lec order by endRegister asc ",RequestOpenCourse.class);
        } else if (Objects.equals(status, "ชำระเงิน")){
            query = session.createQuery("from RequestOpenCourse where course.status =: c_status and lecturer.username =: c_lec order by endPayment asc ",RequestOpenCourse.class);
        }else if(Objects.equals(status, "รอประกาศผล")){
            query = session.createQuery("from RequestOpenCourse where course.status =: c_status and lecturer.username =: c_lec order by applicationResult asc ",RequestOpenCourse.class);
        }else if(Objects.equals(status, "เปิดสอน")){
            query = session.createQuery("from RequestOpenCourse where course.status =: c_status and lecturer.username =: c_lec order by endStudyDate asc ",RequestOpenCourse.class);
        }else if (Objects.equals(status, "เสร็จสิ้น")){
            query = session.createQuery("from RequestOpenCourse where requestStatus =: c_status and lecturer.username =: c_lec order by endStudyDate DESC ",RequestOpenCourse.class);
        }
        assert query != null;
        query.setParameter("c_status", status);
        query.setParameter("c_lec", lec_id);
        return query.getResultList();
    }

    @Override
    public List<RequestOpenCourse> getRequestCourseByTwoStatus(String status1, String status2, String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1, :c_status2) and lecturer.username =: c_lec",RequestOpenCourse.class);
        query.setParameter("c_status1", status1);
        query.setParameter("c_status2", status2);
        query.setParameter("c_lec", lec_id);
        return query.getResultList();
    }

    @Override
    public List<RequestOpenCourse> getRequestCourseByStatusByRegister(String status1, String status2, String status3, String status4,String lec_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1, :c_status2, :c_status3, :c_status4) and lecturer.username =: c_lec order by endRegister asc", RequestOpenCourse.class);
        query.setParameter("c_status1", status1);
        query.setParameter("c_status2", status2);
        query.setParameter("c_status3", status3);
        query.setParameter("c_status4", status4);
        query.setParameter("c_lec", lec_id);
        return query.getResultList();
    }

    @Override
    public List<RequestOpenCourse> getAllRequestByStatusByRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1, :c_status2, :c_status3, :c_status4) and requestStatus =: req_status ORDER BY endRegister asc", RequestOpenCourse.class);
        query.setParameter("c_status1", "ลงทะเบียน");
        query.setParameter("c_status2", "ลงทะเบียน/ชำระเงิน");
        query.setParameter("c_status3", "ชำระเงิน");
        query.setParameter("c_status4", "รอประกาศผล");
        query.setParameter("req_status","ผ่าน");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getNoMaxRequestByStatusByRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1) and requestStatus =: req_status and quantity > registerList.size ORDER BY endRegister asc", RequestOpenCourse.class);
        query.setParameter("c_status1", "ลงทะเบียน");
        query.setParameter("req_status","ผ่าน");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getRegisAndPayRequestByStatusByRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1) and requestStatus =: req_status and quantity > registerList.size ORDER BY endRegister asc", RequestOpenCourse.class);
        query.setParameter("c_status1", "ลงทะเบียน/ชำระเงิน");
        query.setParameter("req_status","ผ่าน");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getPayRequestByStatusByRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1) and requestStatus =: req_status ORDER BY endPayment asc", RequestOpenCourse.class);
        query.setParameter("c_status1", "ชำระเงิน");
        query.setParameter("req_status","ผ่าน");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getAllRequestByStatusByMaxRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1, :c_status2, :c_status3) and requestStatus =: req_status and quantity <= registerList.size ORDER BY applicationResult asc", RequestOpenCourse.class);
        query.setParameter("c_status1", "ลงทะเบียน");
        query.setParameter("c_status2", "ลงทะเบียน/ชำระเงิน");
        query.setParameter("c_status3", "ชำระเงิน");
        query.setParameter("req_status","ผ่าน");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getAppRequestByStatusByRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1) and requestStatus =: req_status ORDER BY applicationResult asc", RequestOpenCourse.class);
        query.setParameter("c_status1", "รอประกาศผล");
        query.setParameter("req_status","ผ่าน");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getAllRequestByStatusByStudy() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where course.status IN (:c_status1) and requestStatus =: req_status ORDER BY endStudyDate asc", RequestOpenCourse.class);
        query.setParameter("c_status1", "เปิดสอน");
        query.setParameter("req_status","ผ่าน");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getAllRequestByStatusByFinishStudy() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where requestStatus =: req_status ORDER BY endStudyDate DESC ", RequestOpenCourse.class);
        query.setParameter("req_status","เสร็จสิ้น");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getAllCancelRequestByStatus() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where requestStatus =: req_status ORDER BY requestDate desc", RequestOpenCourse.class);
        query.setParameter("req_status","ถูกยกเลิก");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }

    @Override
    public List<RequestOpenCourse> getAllRequestBeforeApprove() {
        Session session = sessionFactory.getCurrentSession();
        Query<RequestOpenCourse> query = session.createQuery("from RequestOpenCourse where requestStatus =: req_status ORDER BY endRegister asc ", RequestOpenCourse.class);
        query.setParameter("req_status","รอดำเนินการ");
        List<RequestOpenCourse> requestOpenCourses = query.getResultList();
        return requestOpenCourses;
    }


}
