package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.RequestOpenCourse;
import lifelong.model.RequestOpenCourseFormItem;
import lifelong.service.CourseService;
import lifelong.service.LecturerService;
import lifelong.service.RequestOpCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/request_open_course")
public class RequestOpCourseController {
    @Autowired
    private CourseService courseService;
    @Autowired
    private RequestOpCourseService requestOpCourseService;

    @Autowired
    private LecturerService lecturerService;

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
    public String deleteProduct(@PathVariable("id") long id) {
        requestOpCourseService.deleteRequestOpenCourse(id);
        return "redirect:/request_open_course/list_request_open_course";
    }

    @GetMapping("/add_roc")
    public String showFormAddCourse(Model model) {
        model.addAttribute("title", "ร้องขอเปิด" + title);
        model.addAttribute("lecturers",requestOpCourseService.getLecturer());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", new RequestOpenCourseFormItem());
        return "lecturer/add_request_open_course";
    }
    @GetMapping("/{id}/update_page")//เปลี่ยนชื่อ
    public String showFormForUpdate(@PathVariable("id") long id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(id);
        model.addAttribute("title", "แก้ไขคำร้องขอเปิด" + title);
        model.addAttribute("lecturers",requestOpCourseService.getLecturer());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", requestOpenCourse);
        System.out.println(requestOpenCourse.getCourse().getCourse_id());
        return "lecturer/update_request_open_course";
    }

    @PostMapping("/update_roc")
    public String updateRequestOpCourse (@RequestBody RequestOpenCourse requestOpenCourse) {
        requestOpCourseService.updateRequestOpenCourse(requestOpenCourse);
        return "";
    }

    @PostMapping (path="/save")
    public String saveRequest(@RequestParam Map<String, String> allReqParams) throws ParseException {

        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date requestDate = new Date();

        String startRegister = allReqParams.get("startRegister");
        Date startRegisterDate = dateFormat.parse(startRegister);

        String endRegister = allReqParams.get("endRegister");
        Date endRegisterDate = dateFormat.parse(endRegister);

        int quantity = Integer.parseInt(allReqParams.get("quantity"));

        String startStudy = allReqParams.get("startStudyDate");
        Date startStudyDate = dateFormat.parse(startStudy);

        String endStudy = allReqParams.get("endStudyDate");
        Date endStudyDate = dateFormat.parse(endStudy);

        String studyTime = allReqParams.get("studyTime");

        String applicationResult = allReqParams.get("applicationResult");
        Date applicationResultDate = dateFormat.parse(applicationResult);

        String type_learn = allReqParams.get("type_learn");
        String type_teach = allReqParams.get("type_teach");
        String location = allReqParams.get("location");

        String requestStatus = allReqParams.get("requestStatus");
        boolean requestStatusBool;
        if (requestStatus.equals("false")) {
            requestStatusBool = false;
        } else {
            requestStatusBool = true;
        }

        String signature = allReqParams.get("signature");

        String course_id = allReqParams.get("course_id");
        Course course = courseService.getCourseById(course_id);

        String lecturer_username = allReqParams.get("lecturer_username");
        Lecturer lecturer = lecturerService.getLecturerById(lecturer_username);

        System.out.println(startRegisterDate);
        RequestOpenCourse requestOpenCourse = new RequestOpenCourse(requestDate, startRegisterDate, endRegisterDate, quantity, startStudyDate, endStudyDate, studyTime, type_learn, type_teach, applicationResultDate, location, requestStatusBool, signature, course, lecturer);

        requestOpCourseService.saveRequestOpenCourse(requestOpenCourse);

        return "redirect:list_request_open_course";
    }

    @GetMapping("/list_request_open_course")
    public String listCourse(Model model) {
        model.addAttribute("title", "รายการ");
        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCourses());
        return "lecturer/list_request_open_course";
    }
}
