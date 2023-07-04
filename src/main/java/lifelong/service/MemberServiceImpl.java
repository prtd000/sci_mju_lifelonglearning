package lifelong.service;

import lifelong.dao.MemberDao;
import lifelong.model.Member;
import lifelong.model.Register;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
}
