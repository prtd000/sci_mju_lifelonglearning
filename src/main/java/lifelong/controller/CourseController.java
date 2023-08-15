package lifelong.controller;

import lifelong.model.*;
import lifelong.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/course")
public class CourseController {
    private String title = "หลักสูตร";

    @Autowired
    private CourseService courseService;
    @Autowired
    private MajorService majorService;
    @Autowired
    private RequestOpCourseService requestOpCourseService;

    @Autowired
    private ActivityService activityService;
    @Autowired
    private RegisterService registerService;

    @Autowired
    private PaymentService paymentService;
//    @Autowired
//    private RequestOpenCourseService requestOpenCourseService;

    @GetMapping("/")
    public String listCourse(Model model) {
        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("courses", courseService.getCourses());
        return "home";
    }

    @GetMapping("/list_all_course")
    public String listAllCourse(Model model) {
        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCourses());
        model.addAttribute("list_activities", activityService.getPublicActivity());
        return "admin/listAllCourse";
    }
//    @GetMapping("/list_request_open_course")
//    public String listRequestCourse(Model model) {
//        model.addAttribute("title", "รายการ");
//        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCourses());
//        return "admin/listAllCourse";
//    }
    @GetMapping("/view_request_open_course/{request_id}")
    public String showRequestOpenCourse(@PathVariable("request_id") long request_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(request_id);
        model.addAttribute("title", "ดูข้อมูลการร้องขอ");
        model.addAttribute("ROC_detail", requestOpenCourse);
        return "admin/view_request_open_course_by_admin";
    }
    @PostMapping(path="/view_request_open_course/{request_id}/approve")
    public String approveRequestOpenCourse(@PathVariable("request_id") long roc_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
        RequestOpenCourse existingRequestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        if (existingRequestOpenCourse != null) {
            existingRequestOpenCourse.setRequestStatus("ผ่าน");
            requestOpCourseService.updateRequestOpenCourse(existingRequestOpenCourse);
        }
        return "redirect:/course/list_all_course";
    }
    @GetMapping("/note_cancel_request_open_course/{request_id}")
    public String noteCancelRequestOpenCourse(@PathVariable("request_id") long request_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(request_id);
        model.addAttribute("ROC_detail", requestOpenCourse);
        return "admin/note_not_pass_detail";
    }
    @PostMapping(path="/note_cancel_request_open_course/{request_id}/cancel")
    public String cancelRequestOpenCourse(@PathVariable("request_id") long roc_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
        RequestOpenCourse existingRequestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        if (existingRequestOpenCourse != null) {
            existingRequestOpenCourse.setRequestStatus("ไม่ผ่าน");
            existingRequestOpenCourse.setNote(allReqParams.get("cancelReason"));
            requestOpCourseService.updateRequestOpenCourse(existingRequestOpenCourse);
        }
        return "redirect:/course/list_all_course";
    }
    @GetMapping("/{id}/course_detail")
    public String showCourseDetailByAdmin(@PathVariable("id") String id, Model model) {
        Course course = courseService.getCourseDetail(id);
        model.addAttribute("title", "รายละเอียด" + title);
        model.addAttribute("course_detail", course);
        return "admin/course_detail_by_admin";
    }
    @GetMapping("/{id}")
    public String showCourseDetail(@PathVariable("id") String id, Model model) {
        Course course = courseService.getCourseDetail(id);
        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("course_detail", course);
        return "course/course-detail";
    }

    @GetMapping("/add_course")
    public String showFormAddCourse(Model model) {
        model.addAttribute("title", "เพิ่ม" + title);
        model.addAttribute("majors", majorService.getMajors());
        model.addAttribute("add_course", new Course());
        return "admin/addCourse";
    }
    @GetMapping("/add_major")
    public String showFormAddMajor(Model model) {
        model.addAttribute("title", "เพิ่ม" + title);
        model.addAttribute("add_major", new Major());
        return "admin/addMajor";
    }

    @PostMapping(path="/admin/save")
    public String saveAddCourse(@RequestParam Map<String, String> allReqParams) throws ParseException {
        String course_id = allReqParams.get("course_id");
        String course_name = allReqParams.get("course_name");
        String certificateName = allReqParams.get("certificateName");
        String course_img = allReqParams.get("course_img");
        String course_principle = allReqParams.get("course_principle");
        String course_object = allReqParams.get("course_object");
        int course_totalHours = Integer.parseInt(allReqParams.get("course_totalHours"));
        String course_targetOccupation = allReqParams.get("course_targetOccupation");
        double course_fee = Double.parseDouble(allReqParams.get("course_fee"));
        String course_file = allReqParams.get("course_file");
        String course_status = allReqParams.get("course_status");
        String course_linkMooc = allReqParams.get("course_linkMooc");
        String course_type = allReqParams.get("course_type");
        Major major = majorService.getMajorDetail(allReqParams.get("major_id"));

        Course course_add = new Course(course_id,course_name,certificateName,course_img,course_principle,course_object,course_totalHours,
                course_targetOccupation,course_fee,course_file,course_status,course_linkMooc,course_type,major);
        courseService.doAddCourse(course_add);
        return "redirect:/";
    }

    @GetMapping("/{id}/edit_course")
    public String showEditCourse(@PathVariable("id") String id, Model model) {
        Course course = courseService.getCourseById(id);
        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("majors", majorService.getMajors());
        model.addAttribute("course", course);
        return "admin/editCourse";
    }

    @PostMapping (path="/{id}/update_edit_course")
    public String updateCourse(@PathVariable("id") String course_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
        Course existingCourse = courseService.getCourseById(course_id);
        if (existingCourse != null) {
            existingCourse.setCourse_id(allReqParams.get("course_id"));
            existingCourse.setName(allReqParams.get("course_name"));
            existingCourse.setCertificateName(allReqParams.get("certificateName"));
            existingCourse.setImg(allReqParams.get("course_img"));
            existingCourse.setPrinciple(allReqParams.get("course_principle"));
            existingCourse.setObject(allReqParams.get("course_object"));
            existingCourse.setTotalHours(Integer.parseInt(allReqParams.get("course_totalHours")));
            existingCourse.setTargetOccupation(allReqParams.get("course_targetOccupation"));
            existingCourse.setFee(Double.parseDouble(allReqParams.get("course_fee")));
            existingCourse.setFile(allReqParams.get("course_file"));
            existingCourse.setStatus(allReqParams.get("course_status"));
            existingCourse.setLinkMooc(allReqParams.get("course_linkMooc"));
            existingCourse.setCourse_type(allReqParams.get("course_type"));
            existingCourse.setMajor(majorService.getMajorDetail(allReqParams.get("major_id")));
            courseService.updateCourse(existingCourse);
        }
        return "redirect:/course/list_all_course";
    }

    @GetMapping("/view_approve_request_open_course/{id}")
    public String showRequestApproveOpenCourse(@PathVariable("id") long id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(id);
        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("RAOC_detail", requestOpenCourse);
        return "admin/view_Approve_request_open_course_by_admin";
    }

    @GetMapping("/{roc_id}/list_member_to_course")
    public String showListMemberToRequestCourse(@PathVariable("roc_id") long roc_id, Model model) {
        List<Register> register = registerService.getRegisterByRequestId(roc_id);
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("register_detail", register);
        model.addAttribute("request_name", requestOpenCourse);
        return "admin/list_Approve_member_to_course";
    }
    @GetMapping("/{request_id}/view_payment_detail/{invoice_id}")
    public String showPaymentDetailToApprove(@PathVariable("request_id") long request_id ,@PathVariable("invoice_id") long invoiceId , Model model) {
        Receipt receipt = paymentService.getReceiptByInvoiceId(invoiceId);
        model.addAttribute("payment",receipt);
        model.addAttribute("request_id",request_id);
        return "admin/view_payment_detail";
    }

    @PostMapping(path="/{request_id}/view_payment_detail/{invoice_id}/approve")
    public String approveMemberToCourse(@PathVariable("request_id") long request_id,@PathVariable("invoice_id") long invoice_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
        Invoice invoice = paymentService.getInvoiceById(invoice_id);
        if (invoice != null) {
            invoice.setApprove_status("ผ่าน");
            paymentService.updateInvoice(invoice);
        }
        return "redirect:/course/list_all_course";
    }
    @GetMapping("/{request_id}/list_member_to_approve")
    public String showListMemberToApprove(@PathVariable("request_id") long request_id , Model model) {
        List<Register> register = registerService.getRegisterByRequestIdAndPayStatus(request_id);
        model.addAttribute("title","TEST");
        model.addAttribute("registers",register);
        return "lecturer/list_member_approve_course";
    }
    @PostMapping(path="/{request_id}/update_Status_Member_Result/{register_id}")
    public String updateStatusMemberResult(
            @PathVariable("request_id") long request_id,
            @PathVariable("register_id") long register_id,
            @RequestParam Map<String, String> allReqParams) throws ParseException {

        String studyResult = allReqParams.get("studyResult");
        Register register = registerService.getRegisterByRegisterId(register_id);
        // ตรวจสอบค่า studyResult และดำเนินการตามที่คุณต้องการ
        if ("ผ่านหลักสูตร".equals(studyResult)) {
            register.setStudy_result(true);
        } else if ("ไม่ผ่านหลักสูตร".equals(studyResult)) {
            register.setStudy_result(false);
        }
        registerService.updateRegister(register);

        return "redirect:/course/"+request_id+"/list_member_to_approve";
    }
}
