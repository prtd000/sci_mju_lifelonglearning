package lifelong.dao;

import lifelong.model.Admin;
import lifelong.model.Lecturer;
import lifelong.model.Member;

import java.util.List;

public interface UserDao {

    Member getMemberByUsername (String id);

    Lecturer getLecturerByUsername (String id);

    Admin getAdminByUsername (String id);


    List<Member> getUsernames ();
}
