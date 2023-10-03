package lifelong.controller;

import lifelong.model.Admin;
import lifelong.model.Lecturer;
import lifelong.model.Member;
import lifelong.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @PostMapping("/doLoginMember")
    public String doLoginMember (@RequestParam Map<String, String> map, Model model, HttpSession session) {
        String username = map.get("username");
        String password = map.get("password");
        Member member = userService.loginMember(username,password);

        if (member != null) {
            session.setAttribute("member", member);
//            session.setMaxInactiveInterval(60 * 5);
            return "redirect:/";
        } else {
            model.addAttribute("loginFailed", true);
            return "redirect:/access-denied";
        }

//        if (admin == null && lecturer == null && member == null){
//            model.addAttribute("loginFailed", true);
//            return "access-denied";
//        } else {
//            if (admin != null) {
//                session.setAttribute("admin", admin);
//            }
//            if (lecturer != null) {
//                session.setAttribute("lecturer",lecturer);
//            }
//            if (member != null) {
//                session.setAttribute("member",member);
//            }
//            session.setMaxInactiveInterval(60 * 5);
//            return "redirect:/";
//        }
    }

    @PostMapping("/doLoginLecturer")
    public String doLoginLecturer (@RequestParam Map<String, String> map, Model model, HttpSession session) {
        String username = map.get("username");
        String password = map.get("password");
        Lecturer lecturer = userService.loginLecturer(username,password);

        if (lecturer != null) {
            session.setAttribute("lecturer", lecturer);
            session.setMaxInactiveInterval(60 * 5);
            return "redirect:/";
        } else {
            return "redirect:/access-denied";
        }
    }

    @PostMapping("/doLoginAdmin")
    public String doLoginAdmin (@RequestParam Map<String, String> map, Model model, HttpSession session) {
        String username = map.get("username");
        String password = map.get("password");
        Admin admin = userService.loginAdmin(username,password);

        if (admin != null) {
            session.setAttribute("admin", admin);
            session.setMaxInactiveInterval(60 * 5);
            return "redirect:/";
        }else {
            return "redirect:/access-denied";
        }
    }

    @RequestMapping("/doLogout")
    public String doLogout (HttpSession session) {
        session.setAttribute("member", null);
        session.setAttribute("lecturer", null);
        session.setAttribute("admin", null);
        return "redirect:/";
    }
}
