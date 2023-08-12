package lifelong.dao;

import lifelong.model.Invoice;
import lifelong.model.Receipt;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.hibernate.query.Query;

import javax.persistence.NoResultException;
import javax.swing.*;

@Repository
public class PaymentDaoImpl implements PaymentDao{

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Invoice getInvoiceById(long invoice_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Invoice> query = session.createQuery("FROM Invoice i where i.id =: Id ",Invoice.class);
        query.setParameter("Id",invoice_id);
        Invoice invoice = query.getSingleResult();
        return invoice;
    }

    @Override
    public Receipt getReceiptById(long receipt_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Receipt> query = session.createQuery("FROM Receipt r where r.id =: Id  ", Receipt.class);
        query.setParameter("Id",receipt_id);
        Receipt receipt = query.getSingleResult();
        return receipt;
    }
    @Override
    public Receipt getReceiptByInvoiceId(long invoice_id) {
        Session session = sessionFactory.getCurrentSession();
        Query<Receipt> query = session.createQuery("FROM Receipt r where r.invoice.id = :Id", Receipt.class);
        query.setParameter("Id", invoice_id);

        try {
            Receipt receipt = query.getSingleResult();
            System.out.println(receipt);
            return receipt;
        } catch (NoResultException e) {
            // ไม่พบข้อมูล ในกรณีนี้คุณสามารถจัดการตามที่คุณต้องการได้
            // เช่น คืนค่า null, คืนค่าว่าง, หรือส่งกลับข้อความบอกว่าไม่พบข้อมูล
            return null; // หรือ return ค่าที่คุณต้องการ
        }
    }

    @Override
    public void saveReceipt(Receipt receipt) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(receipt);
    }

    @Override
    public Invoice updateInvoice(Invoice invoice) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(invoice);
        return invoice;
    }

    @Override
    public Receipt getLastRowReceipt() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Receipt r ORDER BY r.id DESC");
        query.setMaxResults(1);
        Receipt receipt = (Receipt) query.uniqueResult();
        return receipt;
    }
}
