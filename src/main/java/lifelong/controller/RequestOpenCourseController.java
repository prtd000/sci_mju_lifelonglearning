package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;
import lifelong.service.CourseService;
import lifelong.service.LecturerService;
import lifelong.service.MajorService;
import lifelong.service.RequestOpenCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;

@Controller
@RequestMapping("/request")
public class RequestOpenCourseController {

    @Autowired
    private CourseService courseService;
    @Autowired
    private LecturerService lecturerService;
    @Autowired
    private RequestOpenCourseService requestOpenCourseService;
    private String title = "หลักสูตร";

    @GetMapping("/request_open_course")
    public String showFormAddCourse(Model model) {
        model.addAttribute("title", "ร้องขอเปิด" + title);
        model.addAttribute("lecturers", lecturerService.getLecturer());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", new RequestOpenCourse());
        return "lecturer/request_open_course";
    }

    @RequestMapping(path = "/save", method = RequestMethod.POST)
    public String saveRequest(
            @Valid @ModelAttribute("request_open_course") RequestOpenCourse requestOpenCourse, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("title", "มีข้อผิดพลาดในการบันทึก" + title);
            model.addAttribute("lecturers", lecturerService.getLecturer());
            model.addAttribute("courses", courseService.getCourses());
            return "lecturer/request_open_course";
        } else {
            requestOpenCourseService.doRequestOpenCourseDetail(requestOpenCourse);
            return "redirect:/";
        }
    }
}
