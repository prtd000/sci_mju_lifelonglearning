package lifelong.dao;

import lifelong.model.Invoice;
import lifelong.model.Register;

public interface RegisterDao {

    void saveRegister(Register register);

    void doInvoice(Invoice invoice);

    Register getLastRow();


}
