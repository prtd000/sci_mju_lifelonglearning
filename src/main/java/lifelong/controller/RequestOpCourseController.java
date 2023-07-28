package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Lecturer;
import lifelong.model.RequestOpenCourse;
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
        model.addAttribute("request_open_course", new RequestOpenCourse());
        return "lecturer/add_request_open_course";
    }
    @GetMapping("/{id}/update_page")
    public String showFormForUpdate(@PathVariable("id") long id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(id);
        model.addAttribute("title", "แก้ไขคำร้องขอเปิด" + title);
        model.addAttribute("lecturers", requestOpCourseService.getLecturer());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", requestOpenCourse);
        return "lecturer/update_request_open_course";
    }

//    @PostMapping("/update_roc")
//    public String updateRequestOpCourse(@ModelAttribute("request_open_course") RequestOpenCourse requestOpenCourse) {
//        requestOpCourseService.updateRequestOpenCourse(requestOpenCourse);
//        return "redirect:list_request_open_course";
//    }

    @PostMapping("/update_roc")
    public String updateRequestOpCourse(@ModelAttribute("request_open_course") RequestOpenCourse requestOpenCourse) {
        System.out.println(requestOpenCourse.getRequest_id());
//        RequestOpenCourse entityProduct = requestOpCourseService.getRequestOpenCourseDetail(requestOpenCourse.getRequest_id());

        //        if (entityProduct != null) {
//            requestOpCourseService.updateRequestOpenCourse(entityProduct);
//        }
        //requestOpCourseService.updateRequestOpenCourse(requestOpenCourse);
        return "redirect:list_request_open_course";
    }

//    @PostMapping("/update_roc")
//    public String updateRequestOpCourse(@Valid @ModelAttribute("request_open_course") RequestOpenCourse requestOpenCourse, @RequestParam("confirmButton") String confirmButton) {
//        RequestOpenCourse entityProduct = requestOpCourseService.getRequestOpenCourseDetail(requestOpenCourse.getRequest_id());
//        if (entityProduct != null) {
//            requestOpCourseService.updateRequestOpenCourse(requestOpenCourse);
//        } else {
//            requestOpCourseService.doRequestOpenCourseDetail(requestOpenCourse);
//        }
//        return "redirect:list_request_open_course";
//    }

//        @PostMapping(path="/{id}/save")
//        public String saveRequest(@PathVariable("id") String lec_id,
//                                  @RequestParam Map<String, String> allReqParams,
//                                  @RequestParam("confirmButton") String confirmButton) throws ParseException {
//
//            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//            Date requestDate = new Date();
//
//            String startRegister = allReqParams.get("startRegister");
//            Date startRegisterDate = dateFormat.parse(startRegister);
//
//            String endRegister = allReqParams.get("endRegister");
//            Date endRegisterDate = dateFormat.parse(endRegister);
//
//            int quantity = Integer.parseInt(allReqParams.get("quantity"));
//
//            String startStudy = allReqParams.get("startStudyDate");
//            Date startStudyDate = dateFormat.parse(startStudy);
//
//            String endStudy = allReqParams.get("endStudyDate");
//            Date endStudyDate = dateFormat.parse(endStudy);
//
//            String studyTime = allReqParams.get("studyTime");
//
//            String applicationResult = allReqParams.get("applicationResult");
//            Date applicationResultDate = dateFormat.parse(applicationResult);
//
//            String type_learn = allReqParams.get("type_learn");
//            String type_teach = allReqParams.get("type_teach");
//            String location = allReqParams.get("location");
//
//            boolean requestStatusBool = false;
//
//            String signature = allReqParams.get("signature");
//
//            String course_id = allReqParams.get("course_id");
//            Course course = courseService.getCourseById(course_id);
//
//            Lecturer lecturer = lecturerService.getLecturerById(lec_id);
//
//            System.out.println(startRegisterDate);
//            RequestOpenCourse requestOpenCourse_toAdd = new RequestOpenCourse(requestDate, startRegisterDate, endRegisterDate, quantity, startStudyDate, endStudyDate, studyTime, type_learn, type_teach, applicationResultDate, location, requestStatusBool, signature, course, lecturer);
////            requestOpCourseService.saveRequestOpenCourse(requestOpenCourse_toAdd);
////            RequestOpenCourse reg = requestOpCourseService.getRequestOpenCourseDetail()
//            // อัปเดตข้อมูลที่มีอยู่ในระบบ (หากต้องการ)
//            long existingRequestId = 13;
////            if (existingRequestId != null && !existingRequestId.isEmpty()) {
//                RequestOpenCourse existingRequest = requestOpCourseService.getRequestOpenCourseDetail(existingRequestId);
//                System.out.println("PASS");
//                if (existingRequest != null) {
//                    existingRequest.setStartRegister(startRegisterDate);
//                    existingRequest.setEndRegister(endRegisterDate);
//                    existingRequest.setQuantity(quantity);
//                    existingRequest.setStartStudyDate(startStudyDate);
//                    existingRequest.setEndStudyDate(endStudyDate);
//                    existingRequest.setStudyTime(studyTime);
//                    existingRequest.setApplicationResult(applicationResultDate);
//                    existingRequest.setType_learn(type_learn);
//                    existingRequest.setType_teach(type_teach);
//                    existingRequest.setLocation(location);
//                    requestOpCourseService.updateRequestOpenCourse(existingRequest);
//                }
////            }
//
//            return "redirect:/request_open_course/list_request_open_course";
//        }


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
        boolean requestStatusBool = false;
        String signature = allReqParams.get("signature");
        Course course = courseService.getCourseById(allReqParams.get("course_id"));
//        String lecturer_username = allReqParams.get("lecturer_username");
        Lecturer lecturer = lecturerService.getLecturerById(lec_id);

        RequestOpenCourse requestOpenCourse_toAdd = new RequestOpenCourse(requestDate, startRegisterDate, endRegisterDate, quantity, startStudyDate, endStudyDate, studyTime, type_learn, type_teach, applicationResultDate, location, requestStatusBool, signature, course, lecturer);
        requestOpCourseService.saveRequestOpenCourse(requestOpenCourse_toAdd);
        return "redirect:/request_open_course/list_request_open_course";
    }
    @PostMapping (path="/{id}/update")
    public String updateRequest(@PathVariable("id") String req_id,@RequestParam Map<String, String> allReqParams) throws ParseException {

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
        return "redirect:/request_open_course/list_request_open_course";
    }
    @GetMapping("/list_request_open_course")
    public String listCourse(Model model) {
        model.addAttribute("title", "รายการ");
        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCourses());
        return "lecturer/list_request_open_course";
    }
}
