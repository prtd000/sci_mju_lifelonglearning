package lifelong.service;

import lifelong.dao.UserDao;
import lifelong.model.Admin;
import lifelong.model.Lecturer;
import lifelong.model.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{


    @Autowired
    private UserDao userDao;

    @Override
    @Transactional
    public Member loginMember(String username, String password) {
        Member member = userDao.getMemberByUsername(username);
        return (member != null && member.getUsername() != null?member:null);
    }

    @Override
    @Transactional
    public Lecturer loginLecturer(String username, String password) {
        Lecturer lecturer = userDao.getLecturerByUsername(username);
        return (lecturer != null && lecturer.getUsername() != null?lecturer:null);
    }

    @Override
    @Transactional
    public Admin loginAdmin(String username, String password) {
        Admin admin = userDao.getAdminByUsername(username);
        return (admin != null && admin.getUsername() != null?admin:null);
    }

}
