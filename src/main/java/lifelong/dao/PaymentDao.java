package lifelong.dao;

import lifelong.model.Invoice;
import lifelong.model.Receipt;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface PaymentDao {

    Invoice getInvoiceById(long invoice_id);

    Invoice getInvoiceByMemberId (String memId);

    List<Invoice> getListInvoiceByMemberId (String memId);

    List<Receipt> getReceiptByMemberId(String memId);

    Receipt getReceiptById(long receipt_id);

    Receipt getReceiptByInvoiceId(long invoice_id);

    void saveReceipt(Receipt receipt);
    Invoice updateInvoice (Invoice invoice) ;

    Receipt getLastRowReceipt();

    int getLatestFileCount();

    int getSlipMaxId();
}
