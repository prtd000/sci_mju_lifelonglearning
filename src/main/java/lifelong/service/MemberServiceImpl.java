package lifelong.service;

import lifelong.dao.MemberDao;
import lifelong.model.Course;
import lifelong.model.Invoice;
import lifelong.model.Member;
import lifelong.model.Register;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDao memberDao;

    @Override
    @Transactional
    public void registerCourse(Register register) {
        memberDao.registerCourse(register);
    }

    @Override
    @Transactional
    public Member getMemberById(String memberId) {
        return memberDao.getMemberById(memberId);
    }

    @Override
    @Transactional
    public void doRegisterMember(Member member) {
        memberDao.doRegisterMember(member);
    }

    @Override
    @Transactional
    public List<Register> getMyListCourse(String memId) {
        return memberDao.getMyListCourse(memId);
    }

    @Override
    @Transactional
    public List<Invoice> getListInvoice() {
        return memberDao.getListInvoice();
    }
}
