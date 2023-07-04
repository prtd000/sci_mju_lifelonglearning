package lifelong.dao;

import lifelong.model.Member;
import lifelong.model.Register;

public interface MemberDao {

    void registerCourse(Register register);

    Member getMemberById (String memberId);
}
