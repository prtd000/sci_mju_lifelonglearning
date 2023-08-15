package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.Register;
import lifelong.model.RequestOpenCourse;
import lifelong.service.ActivityService;
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
    @Autowired
    private ActivityService activityService;

    private String title = "หลักสูตรที่ร้องขอ";
    @GetMapping("/{lec_id}/view_request_open_course/{roc_id}")
    public String showRequestOpenCourse(@PathVariable("lec_id") String lec_id,@PathVariable("roc_id") long roc_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        //model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("ROC_detail", requestOpenCourse);
        return "lecturer/view_request_open_course";
    }

    @GetMapping("/{lec_id}/view_approve_request_open_course/{roc_id}")
    public String showRequestApproveOpenCourse(@PathVariable("lec_id") String lec_id,@PathVariable("roc_id") long roc_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("RAOC_detail", requestOpenCourse);
        model.addAttribute("course_activities",activityService.getActivityDetailByCourseId(roc_id));
        return "lecturer/view_Approve_request_open_course";
    }
    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
    }

    @GetMapping("/{roc_id}/delete")
    public String deleteProduct(@PathVariable("roc_id") long roc_id) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        requestOpCourseService.deleteRequestOpenCourse(roc_id);
        String lec_id = requestOpenCourse.getLecturer().getUsername();
        System.out.println(lec_id);
        return "redirect:/request_open_course/"+ lec_id +"/list_request_open_course";
    }

    @GetMapping("/{lecturer_id}/add_roc")
    public String showFormAddCourse(@PathVariable("lecturer_id") String lecturer_id,Model model) {
        model.addAttribute("title", "ร้องขอเปิด" + title);
        model.addAttribute("lecturer",requestOpCourseService.getLecturerDetail(lecturer_id));
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", new RequestOpenCourse());
        return "lecturer/add_request_open_course";
    }
    @GetMapping("/{roc_id}/update_page")
    public String showFormForUpdate(@PathVariable("roc_id") long roc_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        model.addAttribute("title", "แก้ไขคำร้องขอเปิด" + title);
        model.addAttribute("lecturer", requestOpCourseService.getLecturer());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", requestOpenCourse);
        return "lecturer/update_request_open_course";
    }

    @PostMapping("/update_roc")
    public String updateRequestOpCourse(@ModelAttribute("request_open_course") RequestOpenCourse requestOpenCourse) {
        System.out.println(requestOpenCourse.getRequest_id());
        return "redirect:list_request_open_course";
    }


    @PostMapping (path="/{id}/save")
    public String saveRequest(@PathVariable("id") String lec_id,@RequestParam Map<String, String> allReqParams,@RequestParam("confirmButton") String confirmButton) throws ParseException {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // เปลี่ยนรูปแบบวันที่ให้ตรงกับ HTML
        Date requestDate = new Date();
        Date startRegisterDate = dateFormat.parse(allReqParams.get("startRegister"));
        Date endRegisterDate = dateFormat.parse(allReqParams.get("endRegister"));
        int quantity = Integer.parseInt(allReqParams.get("quantity"));
        Date startStudyDate = dateFormat.parse(allReqParams.get("startStudyDate"));
        Date endStudyDate = dateFormat.parse(allReqParams.get("endStudyDate"));
        String studyTime = allReqParams.get("studyTime");
        Date applicationResultDate = dateFormat.parse(allReqParams.get("applicationResult"));
        String type_learn = allReqParams.get("type_learn");
        String type_teach = allReqParams.get("type_teach");
        String location = allReqParams.get("location");
        String requestStatusBool = "รอดำเนินการ";
        String signature = allReqParams.get("signature");
        Course course = courseService.getCourseById(allReqParams.get("course_id"));
//        String lecturer_username = allReqParams.get("lecturer_username");
        Lecturer lecturer = lecturerService.getLecturerById(lec_id);

        RequestOpenCourse requestOpenCourse_toAdd = new RequestOpenCourse(requestDate, startRegisterDate, endRegisterDate, quantity, startStudyDate, endStudyDate, studyTime, type_learn, type_teach, applicationResultDate, location, requestStatusBool, signature, course, lecturer);
        requestOpCourseService.saveRequestOpenCourse(requestOpenCourse_toAdd);
        return "redirect:/request_open_course/"+ lec_id +"/list_request_open_course";
    }
    @PostMapping (path="/{req_id}/update")
    public String updateRequest(@PathVariable("req_id") String req_id,@RequestParam Map<String, String> allReqParams) throws ParseException {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // เปลี่ยนรูปแบบวันที่ให้ตรงกับ HTML

        //boolean requestStatusBool = false;

//        Lecturer lecturer = lecturerService.getLecturerById(lec_id);

        long existingRequestId = Long.parseLong(req_id);
        RequestOpenCourse existingRequest = requestOpCourseService.getRequestOpenCourseDetail(existingRequestId);
        System.out.println("PASS");
        if (existingRequest != null) {
            existingRequest.setStartRegister(dateFormat.parse(allReqParams.get("startRegister")));
            existingRequest.setEndRegister(dateFormat.parse(allReqParams.get("endRegister")));
            existingRequest.setQuantity(Integer.parseInt(allReqParams.get("quantity")));
            existingRequest.setStartStudyDate(dateFormat.parse(allReqParams.get("startStudyDate")));
            existingRequest.setEndStudyDate(dateFormat.parse(allReqParams.get("endStudyDate")));
            existingRequest.setStudyTime(allReqParams.get("studyTime"));
            existingRequest.setApplicationResult(dateFormat.parse(allReqParams.get("applicationResult")));
            existingRequest.setType_learn(allReqParams.get("type_learn"));
            existingRequest.setType_teach(allReqParams.get("type_teach"));
            existingRequest.setLocation(allReqParams.get("location"));
            existingRequest.setSignature(allReqParams.get("signature"));
            existingRequest.setCourse(courseService.getCourseById(allReqParams.get("course_id")));
            requestOpCourseService.updateRequestOpenCourse(existingRequest);
        }
        String lec_id = existingRequest.getLecturer().getUsername();
        return "redirect:/request_open_course/"+ lec_id +"/view_request_open_course/"+ req_id;
    }
    @GetMapping("/{lecturer_id}/list_request_open_course")
    public String listCourse(@PathVariable("lecturer_id") String lecturer_id,Model model) {
        model.addAttribute("title", "รายการ");
        model.addAttribute("lecturer_id", lecturer_id);
        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCoursesByLecturerId(lecturer_id));
        return "lecturer/list_request_open_course";
    }
}
