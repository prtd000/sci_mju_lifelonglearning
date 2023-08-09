package lifelong.dao;

import lifelong.model.Invoice;
import lifelong.model.Receipt;

public interface PaymentDao {

    Invoice getPaymentDetailById(long invoice_id);

    Receipt getReceiptById(long receipt_id);

    void saveReceipt(Receipt receipt);
}
