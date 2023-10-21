package lifelong.dao;

import lifelong.model.*;

import java.util.List;

public interface RegisterDao {

    List<Register> getListRegister();

    List<Register> getRegister(String memId);

    Register checkMemberRegisteredPass(String memId, long reqId);

    List<Register> getAmountRegisteredByCourseId(String courseId);

    void saveRegister(Register register);

    void deleteRegister(long id);

    void doInvoice(Invoice invoice);

    void deleteInvoice (long register_id);

    Register getLastRow();

    List<Register> getRegisterByRequestId(long roc_Id);

    List<Receipt> getReceipt();

    List<Register> getRegisterByRequestIdAndPayStatus(long roc_Id);
    List<Register> getRegisterByRequestIdAndPayStatusAndApprove(long roc_Id);
    List<Register> getRegisterByRequestIdAndPayStatusAndApproveSortByActionDate(long roc_Id);
    List<Register> getRegisterByRequestIdAndPayStatusAndApproveSortByStatusPass(long roc_Id);

    List<Register> getRegisterByRequestIdAndApprove(long roc_Id);

    Register getRegisterByRegisterId(long register_Id);

    Register updateRegister (Register register) ;
}
