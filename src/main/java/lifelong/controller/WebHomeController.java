package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;
import lifelong.model.RequestOpenCourseFormItem;
import lifelong.service.CourseService;
import lifelong.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebHomeController {
    @Autowired
    private CourseService courseService;

    @Autowired
    private MajorService majorService;

    @GetMapping("/")
    public String listCourse(Model model) {
//        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("courses", courseService.getCourses());
        return "home";
    }
    @GetMapping("/search_course")
    public String searchCourse(Model model) {
//        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("majors",majorService.getMajors());
        return "search_course";
    }

    @GetMapping("/search_course/{value}")
    public String searchCourseByCourseName(Model model, @PathVariable("value") String courseName) {
//        model.addAttribute("title", "รายการ" + title);
        System.out.println(courseName);
        model.addAttribute("courses", courseService.getCoursesByName(courseName));
        model.addAttribute("majors",majorService.getMajors());
        return "search_course";
    }
}
