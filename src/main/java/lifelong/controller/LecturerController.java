package lifelong.controller;

import lifelong.model.*;
import lifelong.service.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/lecturer")
public class LecturerController {
    @Autowired
    private CourseService courseService;
    @Autowired
    private RequestOpCourseService requestOpCourseService;

    @Autowired
    private LecturerService lecturerService;
    @Autowired
    private ActivityService activityService;
    @Autowired
    private RegisterService registerService;

    private String title = "หลักสูตรที่ร้องขอ";
    @Autowired
    private SessionFactory sessionFactory;
    private String Activity_title = "ข่าวสารและกิจกรรม";
    @GetMapping("/{lec_id}/view_request_open_course/{roc_id}")
    public String showRequestOpenCourse(@PathVariable("lec_id") String lec_id,@PathVariable("roc_id") long roc_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        //model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("ROC_detail", requestOpenCourse);
        model.addAttribute("lec_id", lec_id);
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

//    @GetMapping("/{lec_id}/{roc_id}/delete")
//    public String deleteProduct(@PathVariable("lec_id")String lec_id,@PathVariable("roc_id") long roc_id) {
////        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetailToUpdate(roc_id,lec_id);
//        requestOpCourseService.deleteRequestOpenCourse(roc_id,lec_id);
////        String lec_id = requestOpenCourse.getLecturer().getUsername();
//        System.out.println(lec_id);
//        return "redirect:/lecturer/"+ lec_id +"/list_request_open_course";
//    }

    @GetMapping("/{lecturer_id}/add_roc")
    public String showFormAddCourse(@PathVariable("lecturer_id") String lecturer_id,Model model) {
        model.addAttribute("title", "ร้องขอเปิด" + title);
        model.addAttribute("lecturer",requestOpCourseService.getLecturerDetail(lecturer_id));
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", new RequestOpenCourse());
        return "lecturer/add_request_open_course";
    }
    @GetMapping("/{lec_id}/{roc_id}/update_page")
    public String showFormForUpdate(@PathVariable("lec_id") String lec_id,@PathVariable("roc_id") long roc_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetailToUpdate(roc_id,lec_id);
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
        return "redirect:/lecturer/"+ lec_id +"/list_request_open_course";
    }
    @PostMapping (path="/{lec_id}/{req_id}/update")
    public String updateRequest(@PathVariable("lec_id") String lec_id,@PathVariable("req_id") String req_id,@RequestParam Map<String, String> allReqParams) throws ParseException {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // เปลี่ยนรูปแบบวันที่ให้ตรงกับ HTML

        //boolean requestStatusBool = false;

//        Lecturer lecturer = lecturerService.getLecturerById(lec_id);

        long existingRequestId = Long.parseLong(req_id);
        RequestOpenCourse existingRequest = requestOpCourseService.getRequestOpenCourseDetailToUpdate(existingRequestId,lec_id);
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
//        String lec_id = existingRequest.getLecturer().getUsername();
        return "redirect:/lecturer/"+ lec_id +"/view_request_open_course/"+ req_id;
    }
    @GetMapping("/{lecturer_id}/list_request_open_course")
    public String listCourse(@PathVariable("lecturer_id") String lecturer_id,Model model) {
        model.addAttribute("title", "รายการ");
        model.addAttribute("lecturer_id", lecturer_id);
        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCoursesByLecturerId(lecturer_id));
        return "lecturer/list_request_open_course";
    }
    @GetMapping("/{lecturer_id}/{request_id}/list_member_to_approve")
    public String showListMemberToApprove(@PathVariable("lecturer_id") String lecturer_id,@PathVariable("request_id") long request_id , Model model) {
        List<Register> register = registerService.getRegisterByRequestIdAndPayStatus(request_id);
        model.addAttribute("title","TEST");
        model.addAttribute("registers",register);
        model.addAttribute("lecturer_id",lecturer_id);
        return "lecturer/list_member_approve_course";
    }
    @GetMapping("/{lec_id}/private/{id}/edit_course_activity_page/{roc_id}")
    public String showEditCourseActivity(@PathVariable("lec_id") String lec_id,@PathVariable("id") long id,@PathVariable("roc_id") long roc_id, Model model) {
        Activity activity = activityService.getActivityDetailToUpdate(id,lec_id);
        model.addAttribute("title", "แก้ไข" + Activity_title + "ทั่วไป");
        model.addAttribute("activities", activity);
        model.addAttribute("request_id", roc_id);
        return "lecturer/edit_Course_Activity";
    }


    @PostMapping (path="/{lec_id}/{id}/update_course_add_activity")
    public String updateCourseActivity(@PathVariable("lec_id") String lec_id,@PathVariable("id") long ac_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
//        long existingActivityId = Long.parseLong(ac_id);
        Activity existingActivity = activityService.getActivityDetailToUpdate(ac_id,lec_id);
        System.out.println("PASS");
        if (existingActivity != null) {
            existingActivity.setName(allReqParams.get("ac_name"));
            existingActivity.setDetail(allReqParams.get("ac_detail"));
            existingActivity.setImg(allReqParams.get("ac_img"));
            activityService.updateActivity(existingActivity);
        }
        return "redirect:/lecturer/"+lec_id+"/"+ac_id+"/view_course_activity_page/"+existingActivity.getRequestOpenCourse().getRequest_id();
    }

    @GetMapping("/{lec_id}/{id}/delete")
    public String deleteActivity(@PathVariable("lec_id") String lec_id,@PathVariable("id") long id) {
        Activity activity = activityService.getActivityDetail(id);
            activityService.deleteCourseActivity(id,lec_id);
            return "redirect:/lecturer/"+lec_id+"/view_approve_request_open_course/"+activity.getRequestOpenCourse().getRequest_id();
    }

    @GetMapping("/{roc_id}/add_course_activity")
    public String showFormAddCourseActivity(Model model, @PathVariable("roc_id") long roc_id) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        model.addAttribute("title", "เพิ่มข่าวสารประจำหลักสูตร");
        model.addAttribute("ROC_detail", requestOpenCourse);
//        model.addAttribute("add_public_activity", new Activity());
        return "lecturer/add_Course_Activity";
    }
    @Transactional
    @PostMapping (path="/{lec_id}/save_add_course_activity/{roc_id}")
    public String saveAddRequestCourseActivity(@PathVariable("lec_id") String lec_id,@PathVariable("roc_id") long roc_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
        Date ac_date =  new Date();
        String ac_name = allReqParams.get("ac_name");
        String ac_detail = allReqParams.get("ac_detail");
        String ac_img = allReqParams.get("ac_img");
        String ac_type = "Private";
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        Lecturer lecturer = lecturerService.getLecturerById(lec_id);

        Activity public_activity_add = new Activity(ac_name,ac_date,ac_detail,ac_type,ac_img,requestOpenCourse,lecturer);

        Session session = sessionFactory.getCurrentSession();

        // ใช้ session.merge() เพื่อรวมหรืออัปเดตอ็อบเจกต์ลงใน session
        Activity mergedActivity = (Activity) session.merge(public_activity_add);

        // เพิ่มกิจกรรมเข้าสู่ระบบโดยใช้อ็อบเจกต์ที่รวมแล้ว
        activityService.addActivityNews(mergedActivity);
        return "redirect:/lecturer/"+lec_id+"/view_approve_request_open_course/"+roc_id;
    }

    @GetMapping("/{lec_id}/{ac_id}/view_course_activity_page/{roc_id}")
    public String showCourseActivityDetail(@PathVariable("lec_id") String lec_id,@PathVariable("ac_id") long ac_id,@PathVariable("roc_id") long roc_id, Model model) {
        Activity activity = activityService.getActivityDetailToUpdate(ac_id,lec_id);
        model.addAttribute("title", "รายละเอียด" + Activity_title + "ทั่วไป");
        model.addAttribute("activities", activity);
        model.addAttribute("request_id", roc_id);
        return "lecturer/view_detail_course_activity";
    }
}
