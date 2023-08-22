package lifelong.service;

import lifelong.model.Admin;
import lifelong.model.Lecturer;
import lifelong.model.Member;

import java.util.List;

public interface UserService {

    Member loginMember (String username , String password);

    Lecturer loginLecturer (String username ,String password);

    Admin loginAdmin (String username , String password);


    List<Member> getUsernames ();
}
