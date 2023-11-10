package lifelong.service;

import lifelong.dao.RegisterDao;
import lifelong.model.Invoice;
import lifelong.model.Receipt;
import lifelong.model.Register;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RegisterServiceImpl implements RegisterService {

    @Autowired
    private RegisterDao registerDao;

    @Override
    @Transactional
    public List<Register> getListRegister() {
        return registerDao.getListRegister();
    }

    @Override
    @Transactional
    public List<Register> getRegister(String memId) {
        return registerDao.getRegister(memId);
    }

    @Override
    @Transactional
    public List<Register> getRegisterByRequestId(long roc_Id) {
        return registerDao.getRegisterByRequestId(roc_Id);
    }

    @Override
    @Transactional
    public List<Register> getRegisterByRequestIdByLecturer(long roc_Id, String status) {
        return registerDao.getRegisterByRequestIdByLecturer(roc_Id,status);
    }

    @Override
    @Transactional
    public Register checkMemberRegisteredPass(String memId, long reqId) {
        return registerDao.checkMemberRegisteredPass(memId,reqId);
    }

    @Override
    @Transactional
    public List<Register> getAmountRegisteredByCourseId(String courseId) {
        return registerDao.getAmountRegisteredByCourseId(courseId);
    }

    @Override
    @Transactional
    public List<Register> getAmountRegistered() {
        return registerDao.getAmountRegistered();
    }

    @Override
    @Transactional
    public List<Receipt> getReceipt() {
        return registerDao.getReceipt();
    }

    @Override
    @Transactional
    public List<Register> getRegisterByRequestIdAndPayStatus(long roc_Id) {
        return registerDao.getRegisterByRequestIdAndPayStatus(roc_Id);
    }

    @Override
    @Transactional
    public List<Register> getRegisterByRequestIdAndPayStatusAndApprove(long roc_Id) {
        return registerDao.getRegisterByRequestIdAndPayStatusAndApprove(roc_Id);
    }

    @Override
    @Transactional
    public List<Register> getRegisterByRequestIdAndPayStatusAndApproveSortByActionDate(long roc_Id) {
        return registerDao.getRegisterByRequestIdAndPayStatusAndApproveSortByActionDate(roc_Id);
    }

    @Override
    @Transactional
    public List<Register> getRegisterByRequestIdAndPayStatusAndApproveSortByStatusPass(long roc_Id) {
        return registerDao.getRegisterByRequestIdAndPayStatusAndApproveSortByStatusPass(roc_Id);
    }

    @Override
    @Transactional
    public List<Register> getRegisterByRequestIdAndApprove(long roc_Id) {
        return registerDao.getRegisterByRequestIdAndApprove(roc_Id);
    }

    @Override
    @Transactional
    public Register getRegisterByRegisterId(long register_Id) {
        return registerDao.getRegisterByRegisterId(register_Id);
    }
    @Override
    @Transactional
    public Register getLastRow() {
        return registerDao.getLastRow();
    }

    @Override
    @Transactional
    public void saveRegister(Register register) {
        registerDao.saveRegister(register);
    }

    @Override
    @Transactional
    public void deleteRegister(long id) {
        registerDao.deleteRegister(id);
    }

    @Override
    @Transactional
    public void doInvoice(Invoice invoice) {
        registerDao.doInvoice(invoice);
    }

    @Override
    @Transactional
    public void deleteInvoice(long id) {
        registerDao.deleteInvoice(id);
    }

    @Override
    @Transactional
    public void updateRegister(Register register) {
        registerDao.updateRegister(register);
    }

    @Override
    @Transactional
    public List<Register> getRegisterByRequestIdOrderByStatus(long roc_Id, String status) {
        return registerDao.getRegisterByRequestIdOrderByStatus(roc_Id,status);
    }

    @Override
    @Transactional
    public Register getRegisterByRegisterIdAndMemberId(long register_id, String memberId) {
        return registerDao.getRegisterByRegisterIdAndMemberId(register_id,memberId);
    }
}
