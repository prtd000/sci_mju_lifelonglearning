package lifelong.service;

import lifelong.model.Course;
import lifelong.model.Member;
import lifelong.model.Register;

public interface MemberService {
    public void registerCourse(Register register);

    Member getMemberById (String memberId);
}
