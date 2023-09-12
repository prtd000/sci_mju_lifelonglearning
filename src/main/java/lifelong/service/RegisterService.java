package lifelong.service;

import lifelong.model.Invoice;
import lifelong.model.Receipt;
import lifelong.model.Register;
import lifelong.model.RequestOpenCourse;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

public interface RegisterService {

    List<Register> getListRegister();
    List<Register> getRegister(String memId);
    List<Register> getRegisterByRequestId(long roc_Id);

    List<Receipt> getReceipt();
    List<Register>getRegisterByRequestIdAndPayStatus(long roc_Id);
    Register getRegisterById(String memId);

    Register getRegisterByRegisterId(long register_Id);

    Register getLastRow();

    void saveRegister (Register register);

    void deleteRegister (long id);

    void doInvoice (Invoice invoice);

    void deleteInvoice (long id);

    void updateRegister(Register register);

}
