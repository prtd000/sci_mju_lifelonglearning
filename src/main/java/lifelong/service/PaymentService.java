package lifelong.service;

import lifelong.model.Invoice;
import lifelong.model.Receipt;
import lifelong.model.RequestOpenCourse;

public interface PaymentService {

    Invoice getInvoiceById(long invoice_id);

    Receipt getReceiptById(long receipt_id);

    Receipt getReceiptByInvoiceId(long invoice_id);

    void saveReceipt(Receipt receipt);

    void updateInvoice(Invoice invoice);

    Receipt getLastRowReceipt();
}