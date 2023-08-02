package lifelong.service;

import lifelong.dao.RegisterDao;
import lifelong.model.Invoice;
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
    public List<Register> getRegister(String memId) {
        return registerDao.getRegister(memId);
    }

    @Override
    @Transactional
    public Register getRegisterById(String memId) {
        return registerDao.getRegisterById(memId);
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
}
