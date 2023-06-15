package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Register;
import lifelong.service.CourseService;
import lifelong.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private CourseService courseService;

    @GetMapping("/{id}/register_course/{memid}")
    public String registerCourse(@PathVariable("id") String id,@PathVariable("memid") String mem_id, Model model) {
        Course course = courseService.getCourseDetail(mem_id);
        model.addAttribute("course_detail", course);
        model.addAttribute("member_id",id);
        model.addAttribute("title","RegisterCourse");
        model.addAttribute("register", new Register());
        return "member/register_course";
    }
}
