package lifelong.controller;

import lifelong.model.*;
import lifelong.service.*;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;
import utils.ImgPath;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

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

//    @GetMapping("/")
//    public String listCourse(Model model) {
//        model.addAttribute("title", "รายการ" + title);
//        model.addAttribute("courses", courseService.getCourses());
//        return "home";
//    }

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

    @PostMapping(path = "/view_request_open_course/{request_id}/approve")
    public String approveRequestOpenCourse(@PathVariable("request_id") long roc_id, @RequestParam Map<String, String> allReqParams) throws ParseException {
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

    @PostMapping(path = "/note_cancel_request_open_course/{request_id}/cancel")
    public String cancelRequestOpenCourse(@PathVariable("request_id") long roc_id, @RequestParam Map<String, String> allReqParams) throws ParseException {
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

    @PostMapping(path = "/admin/save")
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

        Course course_add = new Course(course_id, course_name, certificateName, course_img, course_principle, course_object, course_totalHours,
                course_targetOccupation, course_fee, course_file, course_status, course_linkMooc, course_type, major);
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

    @PostMapping(path = "/{id}/update_edit_course")
    public String updateCourse(@PathVariable("id") String course_id, @RequestParam Map<String, String> allReqParams) throws ParseException {
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
    public String showPaymentDetailToApprove(@PathVariable("request_id") long request_id, @PathVariable("invoice_id") long invoiceId, Model model) {
        Receipt receipt = paymentService.getReceiptByInvoiceId(invoiceId);
        model.addAttribute("payment", receipt);
        model.addAttribute("request_id", request_id);
        return "admin/view_payment_detail";
    }

    @PostMapping(path = "/{request_id}/view_payment_detail/{invoice_id}/approve")
    public String approveMemberToCourse(@PathVariable("request_id") long request_id, @PathVariable("invoice_id") long invoice_id, @RequestParam Map<String, String> allReqParams) throws ParseException {
        Invoice invoice = paymentService.getInvoiceById(invoice_id);
        if (invoice != null) {
            invoice.setApprove_status("ผ่าน");
            paymentService.updateInvoice(invoice);
        }
        return "redirect:/course/list_all_course";
    }

    @PostMapping(path = "/{request_id}/update_Status_Member_Result/{register_id}")
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

        return "redirect:/course/" + request_id + "/list_member_to_approve";
    }

    @GetMapping("/public/list_activity")
    public String listPublicActivityCourse(Model model) {
        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("list_activities", activityService.getPublicActivity());
        return "admin/list_Public_Activity";
    }

    @GetMapping("/public/{id}/view_page")
    public String showActivityDetail(@PathVariable("id") long id, Model model) {
        Activity activity = activityService.getActivityDetail(id);
        model.addAttribute("title", "รายละเอียด" + title + "ทั่วไป");
        model.addAttribute("activities", activity);
        return "admin/view_detail_public_activity";
    }

    @GetMapping("/public/{id}/edit_page")
    public String showEditActivity(@PathVariable("id") long id, Model model) {
        Activity activity = activityService.getActivityDetail(id);
        model.addAttribute("title", "แก้ไข" + title + "ทั่วไป");
        model.addAttribute("activities", activity);
        return "admin/edit_Public_Activity";
    }

    @GetMapping("/public/add_activity")
    public String showFormAddActivity(Model model) {
        model.addAttribute("title", "เพิ่ม" + title);
//        model.addAttribute("add_public_activity", new Activity());
        return "admin/add_Public_Activity";
    }

    @PostMapping(path = "/admin/save_public_add_activity")
    public String saveAddPublicActivity(@RequestParam Map<String, String> allReqParams) throws ParseException {
        String ac_name = allReqParams.get("ac_name");
        Date ac_date = new Date();
        String ac_detail = allReqParams.get("ac_detail");
        String ac_type = "Public";
        String ac_img = allReqParams.get("ac_img");

        Activity public_activity_add = new Activity(ac_name, ac_date, ac_detail, ac_type, ac_img);
        activityService.addActivityNews(public_activity_add);
        return "redirect:/course/list_all_course";
    }

    @PostMapping(path = "/{id}/update_public_add_activity")
    public String updateActivity(@PathVariable("id") String ac_id, @RequestParam Map<String, String> allReqParams) throws ParseException {
        long existingActivityId = Long.parseLong(ac_id);
        Activity existingActivity = activityService.getActivityDetail(existingActivityId);
        System.out.println("PASS");
        if (existingActivity != null) {
            existingActivity.setName(allReqParams.get("ac_name"));
            existingActivity.setDetail(allReqParams.get("ac_detail"));
            existingActivity.setImg(allReqParams.get("ac_img"));
            activityService.updateActivity(existingActivity);
        }
        return "redirect:/course/public/" + ac_id + "/view_page";
    }

    @GetMapping("/{roc_id}/list_course_activity")
    public String listCourseActivity(Model model, @PathVariable("roc_id") long roc_id) {
        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("list_activities", activityService.getPublicActivity());
        return "admin/list_Public_Activity";
    }


    @GetMapping("/add_img")
    public String addImg(Model model) {
        model.addAttribute("list_img",courseService.getAddImg());
        return "admin/add_img";
    }

    @Autowired
    private ServletContext servletContext;

    @PostMapping("/addImg")
    public String addImg(@RequestParam("detail") String detail, @RequestParam("file") MultipartFile file) {
        try {

            // กำหนด path ที่จะบันทึกไฟล์
            String uploadPath = ImgPath.pathImg + "/addImg/";

            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
            Path directoryPath = Paths.get(uploadPath);
            Files.createDirectories(directoryPath);

            // ดึงนามสกุลไฟล์จากชื่อไฟล์
            String originalFileName = file.getOriginalFilename();
            String fileExtension = getFileExtension(originalFileName);
            int latestFileCount = courseService.getLatestFileCount(); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด

            // สร้างรหัสไฟล์ใหม่ในรูปแบบ "IMG_0001", "IMG_0002", ...
            String newFileName = String.format("IMG_%04d%s", ++latestFileCount, fileExtension);

            // บันทึกไฟล์ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
            Path filePath = Paths.get(uploadPath, newFileName);
            Files.write(filePath, file.getBytes());

            // บันทึก path ไปยังฐานข้อมูล
            AddImg newImg = new AddImg(detail, newFileName);
            courseService.doAddImg(newImg);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/"; // หรือไปยังหน้าที่คุณต้องการ
    }

    // รับนามสกุลไฟล์จากชื่อไฟล์
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
            return fileName.substring(dotIndex);
        }
        return "";
    }



}
