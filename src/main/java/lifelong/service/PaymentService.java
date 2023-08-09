package lifelong.service;

import lifelong.model.Invoice;
import lifelong.model.Receipt;

public interface PaymentService {

    Invoice getPaymentDetailById(long invoice_id);

    Receipt getReceiptById(long receipt_id);

    void saveReceipt(Receipt receipt);
}
