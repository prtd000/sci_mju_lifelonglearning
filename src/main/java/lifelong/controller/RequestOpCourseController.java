package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.RequestOpenCourse;
import lifelong.model.RequestOpenCourseFormItem;
import lifelong.service.CourseService;
import lifelong.service.RequestOpCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/request_open_course")
public class RequestOpCourseController {
    @Autowired
    private CourseService courseService;
    @Autowired
    private RequestOpCourseService requestOpCourseService;

    private String title = "หลักสูตรที่ร้องขอ";
    @GetMapping("/view_request_open_course/{id}")
    public String showRequestOpenCourse(@PathVariable("id") long id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(id);
        //model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("ROC_detail", requestOpenCourse);
        return "lecturer/view_request_open_course";
    }

    @GetMapping("/view_approve_request_open_course/{id}")
    public String showRequestApproveOpenCourse(@PathVariable("id") long id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(id);
        //model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("RAOC_detail", requestOpenCourse);
        return "lecturer/view_Approve_request_open_course";
    }
    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
    }

    @GetMapping("/{id}/delete")
    public String deleteProduct(@PathVariable("id") String id) {
        requestOpCourseService.deleteRequestOpenCourse(id);
        return "redirect:/request_open_course/list_request_open_course";
    }

    @GetMapping("/request_open_course")
    public String showFormAddCourse(Model model) {
        model.addAttribute("title", "ร้องขอเปิด" + title);
        model.addAttribute("lecturers",requestOpCourseService.getLecturer());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", new RequestOpenCourseFormItem());
        return "lecturer/request_open_course";
    }
    @GetMapping("/{id}/update")
    public String showFormForUpdate(@PathVariable("id") long id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(id);
        model.addAttribute("title", "แก้ไขคำร้องขอเปิด" + title);
        model.addAttribute("lecturers",requestOpCourseService.getLecturer());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", requestOpenCourse);
        return "lecturer/request_open_course";
    }

    @RequestMapping(path="/save", method = RequestMethod.POST)
    public String saveRequest(@Valid @ModelAttribute("request_open_course") RequestOpenCourseFormItem requestOpenCourseFormItem) {
//    public String saveRequest(@Valid @ModelAttribute("request_open_course") RequestOpenCourse requestOpenCourse, BindingResult bindingResult, Model model) {
//        if (bindingResult.hasErrors()) {
//            model.addAttribute("title", "มีข้อผิดพลาดในการบันทึก" + title);
//            model.addAttribute("lecturers",requestOpCourseService.getLecturer());
//            model.addAttribute("courses", courseService.getCourses());
//            return "lecturer/request_open_course";
//        }else {
//            RequestOpenCourse entityProduct = requestOpCourseService.getRequestOpenCourseDetail(requestOpenCourse.getRequest_id());
//            if (entityProduct != null) {
//                requestOpCourseService.updateRequestOpenCourse(entityProduct, requestOpenCourse);
//            } else {
                //requestOpenCourse.setRequestDate(new Date());
                //requestOpCourseService.doRequestOpenCourseDetail(requestOpenCourse);
//            }
            Date requestDate = new Date();
            Date startRegister = requestOpenCourseFormItem.getStartRegister();
            Date endRegister = requestOpenCourseFormItem.getEndRegister();
            Integer quantity = requestOpenCourseFormItem.getQuantity();
            Date startStudyDate = requestOpenCourseFormItem.getStartStudyDate();
            Date endStudyDate = requestOpenCourseFormItem.getEndStudyDate();
            String studyTime = requestOpenCourseFormItem.getStudyTime();
            String type_learn = requestOpenCourseFormItem.getType_learn();
            String type_teach = requestOpenCourseFormItem.getType_teach();
            Date applicationResult = requestOpenCourseFormItem.getApplicationResult();
            String location = requestOpenCourseFormItem.getLocation();
            Boolean requestStatus = requestOpenCourseFormItem.getRequestStatus();
            String signature = requestOpenCourseFormItem.getSignature();
            String course_id = requestOpenCourseFormItem.getCourse_id();
            String lecturer_username = requestOpenCourseFormItem.getLecturer_username();
            Course course = courseService.getCourseDetail(course_id);
            Lecturer lecturer = requestOpCourseService.getLecturerDetail(lecturer_username);
            RequestOpenCourse requestOpenCourse = new RequestOpenCourse(requestDate,startRegister,endRegister,
                    quantity,startStudyDate,endStudyDate,studyTime,type_learn,type_teach,applicationResult,location,
                    requestStatus,signature,course,lecturer);
            requestOpCourseService.doRequestOpenCourseDetail(requestOpenCourse);
            return "redirect:/request_open_course/list_request_open_course";
//        }
    }

    @GetMapping("/list_request_open_course")
    public String listCourse(Model model) {
        model.addAttribute("title", "รายการ");
        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCourses());
        return "lecturer/list_request_open_course";
    }
}
