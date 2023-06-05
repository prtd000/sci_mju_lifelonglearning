package lifelong.controller;

import lifelong.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebHomeController {
    @Autowired
    private CourseService courseService;

    @GetMapping("/")
    public String listCourse(Model model) {
//        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("courses", courseService.getCourses());
        return "home";
    }
}
