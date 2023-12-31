package lifelong.dao;

import lifelong.model.*;
import org.apache.xmlbeans.SchemaTypeSystem;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Objects;

@Repository
public class RegisterDaoImpl implements RegisterDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<Register> getListRegister() {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register", Register.class);
        return query.getResultList();
    }

    @Override
    public List<Register> getRegister(String memId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.member.id =: Id ", Register.class);
        query.setParameter("Id",memId);
        List<Register> registers = query.getResultList();
        return registers;
    }

    @Override
    public Register checkMemberRegisteredPass(String memId, long reqId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.member.username =: mId and r.requestOpenCourse.request_id =: rId" ,Register.class);
        query.setParameter("mId" , memId);
        query.setParameter("rId" , reqId);
        return query.getSingleResult();
    }

    @Override
    public List<Register> getAmountRegisteredByCourseId(String courseId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.course.course_id =: cId and r.invoice.pay_status = true",Register.class);
        query.setParameter("cId", courseId);
        return query.getResultList();
    }

    @Override
    public List<Register> getAmountRegistered() {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.invoice.pay_status = true",Register.class);
        System.out.println("Member Payment Pass : " + query.getResultList().size());
        return query.getResultList();
    }

    @Override
    public List<Register> getRegisterByRequestId(long roc_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id ", Register.class);
        query.setParameter("Id",roc_Id);
        List<Register> registers = query.getResultList();
        return registers;
    }

    @Override
    public List<Register> getRegisterByRequestIdByLecturer(long roc_Id, String status) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = null;
        List<Register> registers = null;
        if (Objects.equals(status, "ลงทะเบียน")){
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.course.status =: r_status order by register_date asc", Register.class);
        } else if (Objects.equals(status, "ลงทะเบียน/ชำระเงิน")||Objects.equals(status, "ชำระเงิน")||Objects.equals(status, "รอประกาศผล")) {
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.course.status =: r_status order by "
                    + "CASE "
                    + "  WHEN r.invoice.approve_status = 'ผ่าน' THEN 1 "
                    + "  WHEN r.invoice.approve_status = 'ไม่ผ่าน' THEN 2 "
                    + "  WHEN r.invoice.approve_status = 'รอดำเนินการ' THEN 3 "
                    + "END", Register.class);
        } else if (Objects.equals(status, "เปิดสอน")) {
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.course.status =: r_status and " +
                    "r.invoice.approve_status =: a_status " +
                    "order by register_date asc ",Register.class);
            query.setParameter("a_status","ผ่าน");
        }else if (Objects.equals(status, "เสร็จสิ้น")) {
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.requestStatus =: r_status and " +
                    "r.invoice.approve_status =: a_status " +
                    "order by "
                    + "CASE "
                    + "  WHEN r.study_result = 'ผ่าน' THEN 2 "
                    + "  WHEN r.study_result = 'ไม่ผ่าน' THEN 3 "
                    + "  WHEN r.study_result = 'กำลังเรียน' THEN 1 "
                    + "END", Register.class);
            query.setParameter("a_status","ผ่าน");
        }
        assert query != null;
        query.setParameter("Id",roc_Id);
        query.setParameter("r_status",status);
        registers = query.getResultList();
        return registers;
    }

    @Override
    public List<Register> getRegisterByRequestIdOrderByStatus(long roc_Id, String status) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query;
        List<Register> registers = null;
        if (Objects.equals(status, "ลงทะเบียน")){
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.course.status =: r_status order by register_date asc", Register.class);
            query.setParameter("Id",roc_Id);
            query.setParameter("r_status",status);
            registers = query.getResultList();
        } else if (Objects.equals(status, "ลงทะเบียน/ชำระเงิน")||Objects.equals(status, "ชำระเงิน")||Objects.equals(status, "รอประกาศผล")) {
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.course.status =: r_status order by "
                    + "CASE "
                    + "  WHEN r.invoice.approve_status = 'รอดำเนินการ' and r.invoice.pay_status = true THEN 1 "
                    + "  WHEN r.invoice.approve_status = 'ผ่าน' THEN 2 "
                    + "  WHEN r.invoice.approve_status = 'ไม่ผ่าน' THEN 3 "
                    + "  WHEN r.invoice.approve_status = 'รอดำเนินการ' and r.invoice.pay_status = false THEN 4 "
                    + "END", Register.class);
            query.setParameter("Id",roc_Id);
            query.setParameter("r_status",status);
            registers = query.getResultList();
        }else if (Objects.equals(status, "เปิดสอน")){
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.course.status =: r_status order by register_date asc", Register.class);
            query.setParameter("Id",roc_Id);
            query.setParameter("r_status",status);
            registers = query.getResultList();
        } else if (Objects.equals(status, "ถูกยกเลิก")) {
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.requestStatus =: r_status order by "
                    + "CASE "
                    + "  WHEN r.invoice.approve_status = 'รอดำเนินการ' and r.invoice.pay_status = true THEN 1 "
                    + "  WHEN r.invoice.approve_status = 'ผ่าน' THEN 2 "
                    + "  WHEN r.invoice.approve_status = 'ไม่ผ่าน' THEN 3 "
                    + "  WHEN r.invoice.approve_status = 'รอดำเนินการ' and r.invoice.pay_status = false THEN 4 "
                    + "END", Register.class);
            query.setParameter("Id",roc_Id);
            query.setParameter("r_status",status);
            registers = query.getResultList();
        }else if (Objects.equals(status, "เสร็จสิ้น")) {
            query = session.createQuery("from Register r where r.requestOpenCourse.id =: Id and r.requestOpenCourse.requestStatus =: r_status order by "
                    + "CASE "
                    + "  WHEN r.study_result = 'ผ่าน' THEN 1 "
                    + "  WHEN r.study_result = 'ไม่ผ่าน' THEN 2 "
                    + "  WHEN r.study_result = 'กำลังเรียน' THEN 3 "
                    + "END", Register.class);
            query.setParameter("Id",roc_Id);
            query.setParameter("r_status",status);
            registers = query.getResultList();
        }
        return registers;
    }

    @Override
    public List<Receipt> getReceipt() {
        Session session = sessionFactory.getCurrentSession();
        Query<Receipt> query = session.createQuery("from Receipt ", Receipt.class);
        List<Receipt> receipts = query.getResultList();
        return receipts;
    }

    @Override
    public List<Register> getRegisterByRequestIdAndPayStatus(long roc_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.id =: roc_Id AND r.invoice.pay_status = : pay_status", Register.class);
        query.setParameter("roc_Id",roc_Id);
        query.setParameter("pay_status",true);
        List<Register> registers = query.getResultList();
        return registers;
    }

    @Override
    public List<Register> getRegisterByRequestIdAndPayStatusAndApprove(long roc_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.id =: roc_Id AND " +
                "r.invoice.approve_status NOT IN ('ไม่ผ่าน')", Register.class);
        query.setParameter("roc_Id",roc_Id);
        List<Register> registers = query.getResultList();
        System.out.println(query.getResultList().size());
        return registers;
    }

    @Override
    public List<Register> getRegisterByRequestIdAndPayStatusAndApproveSortByActionDate(long roc_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.id =: roc_Id AND " +
                "r.invoice.approve_status NOT IN ('ไม่ผ่าน') ORDER BY register_date DESC", Register.class);
        query.setParameter("roc_Id",roc_Id);
        List<Register> registers = query.getResultList();
        System.out.println(query.getResultList().size());
        return registers;
    }

    @Override
    public List<Register> getRegisterByRequestIdAndPayStatusAndApproveSortByStatusPass(long roc_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.id =: roc_Id AND " +
                "r.invoice.approve_status NOT IN ('ไม่ผ่าน') ORDER BY r.invoice.approve_status DESC", Register.class);
        query.setParameter("roc_Id", roc_Id);
        List<Register> registers = query.getResultList();
        System.out.println(query.getResultList().size());
        return registers;
    }

    @Override
    public List<Register> getRegisterByRequestIdAndApprove(long roc_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("from Register r where r.requestOpenCourse.id =: roc_Id AND " +
                "r.invoice.approve_status =: status", Register.class);
        query.setParameter("roc_Id",roc_Id);
        query.setParameter("status","ผ่าน");
        List<Register> registers = query.getResultList();
        System.out.println(query.getResultList().size());
        return registers;
    }

    @Override
    public Register getRegisterByRegisterId(long register_Id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("FROM Register r WHERE r.register_id =: regisId", Register.class);
        query.setParameter("regisId", register_Id);
        Register register = query.getSingleResult();
        return register;
    }
    @Override
    public void saveRegister(Register register) {
        Session session = sessionFactory.getCurrentSession();
        session.save(register);
    }

    @Override
    public void deleteRegister(long id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Register where id =: Id");
        query.setParameter("Id", id);
        query.executeUpdate();
    }

    @Override
    public void doInvoice(Invoice invoice) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(invoice);
    }

    @Override
    public void deleteInvoice(long register_id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from Invoice i where i.register.register_id =: Id ");
        query.setParameter("Id",register_id);
        query.executeUpdate();
    }

    @Override
    public Register getLastRow() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Register r ORDER BY r.register_id DESC");
        query.setMaxResults(1);
        Register register = (Register) query.uniqueResult();
        return register;
    }
    @Override
    public Register updateRegister (Register register) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(register);
        return register;
    }

    @Override
    public Register getRegisterByRegisterIdAndMemberId(long register_id, String memberId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Register> query = session.createQuery("FROM Register r WHERE r.register_id =: regisId and r.member.username =: m_id", Register.class);
        query.setParameter("regisId", register_id);
        query.setParameter("m_id", memberId);
        Register register = query.getSingleResult();
        return register;
    }
}
