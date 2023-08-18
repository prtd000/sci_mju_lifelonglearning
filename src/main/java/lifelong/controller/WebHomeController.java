package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Member;
import lifelong.service.CourseService;
import lifelong.service.MajorService;
import lifelong.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller
public class WebHomeController {
    @Autowired
    private CourseService courseService;

    @Autowired
    private MajorService majorService;

    @Autowired
    private MemberService memberService;

    @GetMapping("/")
    public String listCourse(Model model) {
//        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("courses", courseService.getCourses());
        return "home";
    }
    @GetMapping("/search_course")
    public String searchCourse(Model model) {
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("majors",majorService.getMajors());
        return "search_course";
    }
    @GetMapping("/{id}")
    public String showCourseDetail(@PathVariable("id") String id, Model model) {
        Course course = courseService.getCourseDetail(id);
//        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("course_detail", course);
        return "course/course-detail";
    }
    @GetMapping("/search_course/{value}")
    public String searchCourseByCourseName(Model model, @PathVariable("value") String courseName) {
//        model.addAttribute("title", "รายการ" + title);
        System.out.println(courseName);
        model.addAttribute("majorName",courseName);
        model.addAttribute("courses", courseService.getCoursesByName(courseName));
        model.addAttribute("majors",majorService.getMajors());
        return "search_course";
    }

    /***********Register Member**********/

    @GetMapping("/register_member")
    public String registerMember() {
        return "register";
    }

    @PostMapping("/register_member/save")
    public String saveAddMember(@RequestParam Map<String, String> addParams) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");

        String idcard = addParams.get("idcard");
        String firstName = addParams.get("firstName");
        String lastName = addParams.get("lastName");
        String hbd = addParams.get("birthday");
        Date birthday = dateFormat.parse(hbd);
        String gender = addParams.get("gender");
        String tel = addParams.get("tel");
        String email = addParams.get("email");
        String education = addParams.get("education");
        String username = addParams.get("username");
        String password = addParams.get("password");

        Member member = new Member(username,password,idcard,firstName,lastName,gender,birthday,email,tel,education);
        memberService.doRegisterMember(member);

        return "redirect:/";
    }
}
