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

    Register checkMemberRegisteredPass(String memId, long reqId);

    List<Register> getAmountRegisteredByCourseId(String courseId);

    List<Register> getAmountRegistered();
    List<Receipt> getReceipt();
    List<Register>getRegisterByRequestIdAndPayStatus(long roc_Id);
    List<Register> getRegisterByRequestIdAndPayStatusAndApprove(long roc_Id);
    List<Register> getRegisterByRequestIdAndPayStatusAndApproveSortByActionDate(long roc_Id);
    List<Register> getRegisterByRequestIdAndPayStatusAndApproveSortByStatusPass(long roc_Id);

    List<Register> getRegisterByRequestIdAndApprove(long roc_Id);

    Register getRegisterByRegisterId(long register_Id);

    Register getLastRow();

    void saveRegister (Register register);

    void deleteRegister (long id);

    void doInvoice (Invoice invoice);

    void deleteInvoice (long id);

    void updateRegister(Register register);
    List<Register> getRegisterByRequestIdOrderByStatus(long roc_Id, String status);

}
