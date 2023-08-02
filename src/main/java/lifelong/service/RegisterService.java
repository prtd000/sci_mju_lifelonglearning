package lifelong.service;

import lifelong.model.Invoice;
import lifelong.model.Register;
import lifelong.model.RequestOpenCourse;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

public interface RegisterService {

    List<Register> getRegister(String memId);

    Register getRegisterById(String memId);

    Register getLastRow();

    void saveRegister (Register register);

    void deleteRegister (long id);

    void doInvoice (Invoice invoice);

    void deleteInvoice (long id);

}
