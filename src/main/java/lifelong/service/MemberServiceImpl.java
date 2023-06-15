package lifelong.service;

import lifelong.dao.MemberDao;
import lifelong.model.Register;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDao memberDao;

    @Override
    public void registerCourse(Register register) {
        memberDao.registerCourse(register);
    }
}
