package lifelong.service;

import lifelong.dao.PaymentDao;
import lifelong.model.Invoice;
import lifelong.model.Receipt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PaymentServiceImpl implements PaymentService{

    @Autowired
    private PaymentDao paymentDao;

    @Override
    @Transactional
    public Invoice getInvoiceById(long invoice_id) {
        return paymentDao.getInvoiceById(invoice_id);
    }

    @Override
    @Transactional
    public Invoice getInvoiceByMemberId(String memId) {
        return paymentDao.getInvoiceByMemberId(memId);
    }

    @Override
    @Transactional
    public List<Invoice> getListInvoiceByMemberId(String memId) {
        return paymentDao.getListInvoiceByMemberId(memId);
    }

    @Override
    @Transactional
    public List<Receipt> getReceiptByMemberId(String memId) {
        return paymentDao.getReceiptByMemberId(memId);
    }

    @Override
    @Transactional
    public Receipt getReceiptById(long receipt_id) {
        return paymentDao.getReceiptById(receipt_id);
    }
    @Override
    @Transactional
    public Receipt getReceiptByInvoiceId(long invoice_id) {
        return paymentDao.getReceiptByInvoiceId(invoice_id);
    }


    @Override
    @Transactional
    public void saveReceipt(Receipt receipt) {
        paymentDao.saveReceipt(receipt);
    }

    @Override
    @Transactional
    public void updateInvoice(Invoice invoice) {
        paymentDao.updateInvoice(invoice);
    }

    @Override
    @Transactional
    public Receipt getLastRowReceipt() {
        return paymentDao.getLastRowReceipt();
    }

    @Override
    @Transactional
    public int getLatestFileCount() {
        return paymentDao.getLatestFileCount();
    }

    @Override
    @Transactional
    public int getSlipMaxId() {
        return paymentDao.getSlipMaxId();
    }
}
