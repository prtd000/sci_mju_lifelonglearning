package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Register;
import lifelong.model.RequestOpenCourse;
import lifelong.service.CourseService;
import lifelong.service.MemberService;
import lifelong.service.RegisterService;
import lifelong.service.RequestOpCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private RegisterService registerService;

    @Autowired
    private RequestOpCourseService requestOpCourseService;

    @GetMapping("/login")
    public String loginPage(Model model) {
        model.addAttribute("title", "Login");
        return "member/login";
    }

    @GetMapping("/access-denied")
    public String showAccessDenied(Model model) {
        model.addAttribute("title", "Access Denied");
        return "member/access-denied";
    }

    @GetMapping("/{memid}/register_course/{courseid}/{requestid}")
    public String gotoRegisterCourse(@PathVariable("memid") String mem_id, @PathVariable("courseid") String courseid, @PathVariable("requestid") long requestid, Model model) {
        Course course = courseService.getCourseDetail(courseid);
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(requestid);
        model.addAttribute("request_op_course", requestOpenCourse);
        model.addAttribute("course_detail", course);
        model.addAttribute("course_id",courseid);
        model.addAttribute("member_id",mem_id);
        model.addAttribute("title","RegisterCourse");
        model.addAttribute("register", new Register());
        return "member/register_course";
    }

    @GetMapping("/{memid}/register_course/{courseid}/{requestid}/register")
    public String registerCourse (@PathVariable("courseid") String courseid, @PathVariable("requestid") String requestid, @PathVariable("memid") String memid) {
        System.out.println(courseid + " : COURSE ID");
        System.out.println(requestid + " : REQ ID");
        System.out.println(memid + " : MEM ID");
        Register register = new Register();
        register.setRegister_date(new Date());
        register.setStudy_result(false);
        register.setCourse(courseService.getCourseDetail(courseid));
        register.setMember(memberService.getMemberById(memid));
        registerService.saveRegister(register);
        return "redirect:/";
    }
}
