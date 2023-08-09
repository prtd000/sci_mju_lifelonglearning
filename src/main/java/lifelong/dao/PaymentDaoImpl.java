package lifelong.dao;

import lifelong.model.Invoice;
import lifelong.model.Receipt;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.hibernate.query.Query;

import javax.swing.*;

@Repository
public class PaymentDaoImpl implements PaymentDao{

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Invoice getPaymentDetailById(long invoice_id) {
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
    public void saveReceipt(Receipt receipt) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(receipt);
    }
}
