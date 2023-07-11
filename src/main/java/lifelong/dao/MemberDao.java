package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Member;
import lifelong.model.Register;

import java.util.List;

public interface MemberDao {

    void registerCourse(Register register);

    Member getMemberById (String memberId);

    List<Register> getListCourse(String memid);
}
