package lifelong.service;

import lifelong.model.Invoice;
import lifelong.model.Register;

import javax.persistence.criteria.CriteriaBuilder;

public interface RegisterService {

    void saveRegister (Register register);

    void doInvoice (Invoice invoice);

    Register getLastRow();
}
