package lifelong.service;

import lifelong.dao.RegisterDao;
import lifelong.model.Register;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RegisterServiceImpl implements RegisterService {

    @Autowired
    private RegisterDao registerDao;

    @Override
    @Transactional
    public void saveRegister(Register register) {
        registerDao.saveRegister(register);
    }
}
