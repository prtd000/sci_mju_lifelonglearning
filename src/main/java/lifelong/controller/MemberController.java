package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Register;
import lifelong.model.RequestOpenCourse;
import lifelong.service.CourseService;
import lifelong.service.MemberService;
import lifelong.service.RequestOpenCourseService;
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

    @Autowired
    private RequestOpenCourseService requestOpenCourseService;

    @GetMapping("/{memid}/register_course/{courseid}/{requestid}")
    public String registerCourse(@PathVariable("memid") String mem_id, @PathVariable("courseid") String courseid, @PathVariable("requestid") String requestid, Model model) {
        Course course = courseService.getCourseDetail(courseid);
        // get RequestID
        // RequestOpenCourse requestOpenCourse = requestOpenCourseService.getRequestOpenCourseDetail(requestid);
        // model.addAttribute("rq_open_course", requestOpenCourse);
        model.addAttribute("course_detail", course);
        model.addAttribute("course_id",courseid);
        model.addAttribute("member_id",mem_id);
        model.addAttribute("title","RegisterCourse");
        model.addAttribute("register", new Register());
        return "member/register_course";
    }
}
