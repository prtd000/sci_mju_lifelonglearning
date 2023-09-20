package lifelong.service;

import lifelong.model.Invoice;
import lifelong.model.Receipt;
import lifelong.model.RequestOpenCourse;

public interface PaymentService {

    Invoice getInvoiceById(long invoice_id);

    Invoice getInvoiceByMemberId (String memId);

    Receipt getReceiptById(long receipt_id);

    Receipt getReceiptByInvoiceId(long invoice_id);

    void saveReceipt(Receipt receipt);

    void updateInvoice(Invoice invoice);

    Receipt getLastRowReceipt();

    int getLatestFileCount();

    int getSlipMaxId();


}
