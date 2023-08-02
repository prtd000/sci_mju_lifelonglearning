package lifelong.service;

import lifelong.model.Course;
import lifelong.model.Invoice;
import lifelong.model.Member;
import lifelong.model.Register;

import java.util.List;

public interface MemberService {
    public void registerCourse(Register register);

    Member getMemberById (String memberId);

    void doRegisterMember(Member member);

    List<Register> getMyListCourse(String memId);

    List<Invoice> getListInvoice();
}
