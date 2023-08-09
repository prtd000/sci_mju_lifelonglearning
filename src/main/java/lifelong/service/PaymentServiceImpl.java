package lifelong.service;

import lifelong.dao.PaymentDao;
import lifelong.model.Invoice;
import lifelong.model.Receipt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PaymentServiceImpl implements PaymentService{

    @Autowired
    private PaymentDao paymentDao;

    @Override
    @Transactional
    public Invoice getPaymentDetailById(long invoice_id) {
        return paymentDao.getPaymentDetailById(invoice_id);
    }

    @Override
    @Transactional
    public Receipt getReceiptById(long receipt_id) {
        return paymentDao.getReceiptById(receipt_id);
    }

    @Override
    @Transactional
    public void saveReceipt(Receipt receipt) {
        paymentDao.saveReceipt(receipt);
    }
}
