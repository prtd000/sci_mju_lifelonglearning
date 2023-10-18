package lifelong.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import lifelong.model.*;
import lifelong.service.*;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import utils.ImgPath;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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


    // รับนามสกุลไฟล์จากชื่อไฟล์
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
            return fileName.substring(dotIndex);
        }
        return "";
    }
    //******************Request Open Course*************************//
//    @GetMapping("/{lecturer_id}/add_roc")
//    public String getCourseRequest(@PathVariable("lecturer_id") String lecturer_id,Model model) {
//        Lecturer lecturer = lecturerService.getLecturerById(lecturer_id);
//        model.addAttribute("title", "ร้องขอเปิด" + title);
//        model.addAttribute("lecturer",lecturer);
//        model.addAttribute("courses", courseService.getCoursesByCourseStatus(lecturer.getMajor().getName()));
//        model.addAttribute("request_select",requestOpCourseService.getRequestOpenCoursesByLecturerIdAndStatus(lecturer_id));
//        model.addAttribute("request_open_course", new RequestOpenCourse());
//        return "lecturer/add_request_open_course_new";
//    }
        @GetMapping("/{lecturer_id}/add_roc")
    public String showTestLec(@PathVariable("lecturer_id") String lecturer_id,Model model) {
            Lecturer lecturer = lecturerService.getLecturerById(lecturer_id);
            List<Course> course_type_C = courseService.getCoursesByCourseStatusAndType(lecturer.getMajor().getName(),"หลักสูตรอบรมระยะสั้น");
            List<Course> course_type_N = courseService.getCoursesByCourseStatusAndType(lecturer.getMajor().getName(),"Non-Degree");
            List<RequestOpenCourse> requestOpenCourses = requestOpCourseService.getRequestOpenCoursesToCheckDateStudy(lecturer.getUsername());
            model.addAttribute("title", "ร้องขอเปิด" + title);
            model.addAttribute("lecturer",lecturer);
            model.addAttribute("courses", courseService.getCoursesByCourseStatus(lecturer.getMajor().getName()));
            model.addAttribute("course_type_C", course_type_C);
            model.addAttribute("course_type_N", course_type_N);
            model.addAttribute("request_select",requestOpCourseService.getRequestOpenCoursesByLecturerIdAndStatus(lecturer_id));
            model.addAttribute("request_open_course", new RequestOpenCourse());
            model.addAttribute("request_open_check_date",requestOpCourseService.getRequestOpenCoursesToCheckDateStudy(lecturer.getUsername()));
            return "lecturer/request_open_course"; // ชื่อหน้าแก้ไขของคุณ
    }
    @Transactional
    @PostMapping (path="/{id}/save")
    public String doRequestOpenCourseDetail(@PathVariable("id") String lec_id,
                                            @RequestParam Map<String, String> allReqParams) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // เปลี่ยนรูปแบบวันที่ให้ตรงกับ HTML
        int round = 0;
        Date requestDate = new Date();
        Date startRegisterDate = dateFormat.parse(allReqParams.get("startRegister"));
        Date endRegisterDate = dateFormat.parse(allReqParams.get("endRegister"));

        int quantity = Integer.parseInt(allReqParams.get("quantity"));
        Date startStudyDate = dateFormat.parse(allReqParams.get("startStudyDate"));
        Date endStudyDate = dateFormat.parse(allReqParams.get("endStudyDate"));
        String studyDay = allReqParams.get("display_for_submit");

        String startStudyTime = allReqParams.get("start_study_time");
        String endStudyTime = allReqParams.get("end_study_time");
        String studyTime = startStudyTime +","+ endStudyTime;

        String type_learn = allReqParams.get("type_learn");
        String type_teach = allReqParams.get("type_teach");
        Date applicationResultDate = dateFormat.parse(allReqParams.get("applicationResult"));
        String requestStatus = "รอดำเนินการ";


        Course course = courseService.getCourseById(allReqParams.get("course_id"));

        Date startPaymentDate = dateFormat.parse(allReqParams.get("startPayment"));
        Date endPaymentDate = dateFormat.parse(allReqParams.get("endPayment"));

        Lecturer lecturer = lecturerService.getLecturerById(lec_id);

        String location = allReqParams.get("location");
        String link_mooc = allReqParams.get("link_mooc");
            // บันทึก path ไปยังฐานข้อมูล
        RequestOpenCourse requestOpenCourse_toAdd;
            if (Objects.equals(type_learn, "เรียนในสถานศึกษา")){
                requestOpenCourse_toAdd = new RequestOpenCourse(round,requestDate,startRegisterDate,endRegisterDate,
                        quantity,startStudyDate,endStudyDate,studyDay,studyTime,type_learn,type_teach,applicationResultDate,
                        requestStatus,course,lecturer);
                requestOpenCourse_toAdd.setLocation(location);
                if (course.getFee() != 0){
                    requestOpenCourse_toAdd.setStartPayment(startPaymentDate);
                    requestOpenCourse_toAdd.setEndPayment(endPaymentDate);
                }
            } else if (Objects.equals(type_learn, "เรียนออนไลน์")) {
                requestOpenCourse_toAdd = new RequestOpenCourse(round,requestDate,startRegisterDate,endRegisterDate,
                        quantity,startStudyDate,endStudyDate,studyDay,studyTime,type_learn,type_teach,applicationResultDate,
                        requestStatus,course,lecturer);
                requestOpenCourse_toAdd.setLinkMooc(link_mooc);
                if (course.getFee() != 0){
                    requestOpenCourse_toAdd.setStartPayment(startPaymentDate);
                    requestOpenCourse_toAdd.setEndPayment(endPaymentDate);
                }
            }else {
                requestOpenCourse_toAdd = new RequestOpenCourse(round,requestDate,startRegisterDate,endRegisterDate,
                        quantity,startStudyDate,endStudyDate,studyDay,studyTime,type_learn,type_teach,applicationResultDate,
                        requestStatus,course,lecturer);
                requestOpenCourse_toAdd.setLocation(location);
                requestOpenCourse_toAdd.setLinkMooc(link_mooc);
                if (course.getFee() != 0){
                    requestOpenCourse_toAdd.setStartPayment(startPaymentDate);
                    requestOpenCourse_toAdd.setEndPayment(endPaymentDate);
                }
            }
            requestOpenCourse_toAdd.setSignature("");
//            requestOpCourseService.saveRequestOpenCourse(requestOpenCourse_toAdd);
            Session session = sessionFactory.getCurrentSession();
            RequestOpenCourse mergedRequestOpenCourse = (RequestOpenCourse) session.merge(requestOpenCourse_toAdd);
            requestOpCourseService.saveRequestOpenCourse(mergedRequestOpenCourse);
        return "redirect:/lecturer/"+ lec_id +"/list_request_open_course";
    }
    //********************************************************//

    //************************* List Request Course & List Approved Course***************************//
    @GetMapping("/{lecturer_id}/list_request_open_course")
    public String doListRequestCourseDetail(@PathVariable("lecturer_id") String lecturer_id,Model model) {
        List<RequestOpenCourse> requestOpenCourse = requestOpCourseService.getRequestOpenCoursesByLecturerId(lecturer_id);
        model.addAttribute("title", "รายการ");
        model.addAttribute("lecturer_id", lecturer_id);
        model.addAttribute("requests_open_course", requestOpenCourse);
        return "lecturer/list_request_open_course";
    }

    @GetMapping("/{lecturer_id}/list_approve_request_open_course")
    public String getListApprovedCourseDetail(@PathVariable("lecturer_id") String lecturer_id,Model model) {
        List<RequestOpenCourse> requestOpenCourse = requestOpCourseService.getRequestOpenCoursesByLecturerId(lecturer_id);
        model.addAttribute("title", "รายการ");
        model.addAttribute("lecturer_id", lecturer_id);
        model.addAttribute("requests_open_course", requestOpenCourse);
        return "lecturer/list_approve_request_open_course";
    }
    //**********************************************************************//

    //*********************Edit Request Course****************************//
//    @GetMapping("/{lec_id}/{roc_id}/update_page")
//    public String getRequestCourseDetail(@PathVariable("lec_id") String lec_id,@PathVariable("roc_id") long roc_id, Model model) {
//        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetailToUpdate(roc_id,lec_id);
//        model.addAttribute("title", "แก้ไขคำร้องขอเปิด" + title);
//        model.addAttribute("lecturer", requestOpCourseService.getLecturer());
//        model.addAttribute("courses", courseService.getCourses());
//        model.addAttribute("request_open_course", requestOpenCourse);
//        return "lecturer/edit_request_open_course";
//    }
    @GetMapping("/{lec_id}/{roc_id}/update_page")
    public String getRequestCourseDetail(@PathVariable("lec_id") String lec_id,@PathVariable("roc_id") long roc_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetailToUpdate(roc_id,lec_id);
        Lecturer lecturer = lecturerService.getLecturerById(lec_id);
        model.addAttribute("title", "แก้ไขคำร้องขอเปิด" + title);
//        model.addAttribute("lecturer", requestOpCourseService.getLecturer());
//        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", requestOpenCourse);

        List<Course> course_type_C = courseService.getCoursesByCourseStatusAndType(lecturer.getMajor().getName(),"หลักสูตรอบรมระยะสั้น");
        List<Course> course_type_N = courseService.getCoursesByCourseStatusAndType(lecturer.getMajor().getName(),"Non-Degree");
        List<RequestOpenCourse> requestOpenCourses = requestOpCourseService.getRequestOpenCoursesToCheckDateStudy(lecturer.getUsername());
        model.addAttribute("title", "ร้องขอเปิด" + title);
        model.addAttribute("lecturer",lecturer);
        model.addAttribute("courses", courseService.getCoursesByCourseStatus(lecturer.getMajor().getName()));
        model.addAttribute("course_type_C", course_type_C);
        model.addAttribute("course_type_N", course_type_N);
        model.addAttribute("request_select",requestOpCourseService.getRequestOpenCoursesByLecturerIdAndStatus(lec_id));
        model.addAttribute("request_open_check_date",requestOpCourseService.getRequestOpenCoursesToCheckDateStudy(lecturer.getUsername()));


        return "lecturer/edit_request_open_course_new";
    }
    @Transactional
    @PostMapping (path="/{lec_id}/{req_id}/update")
    public String doEditRequestCourseDetail(@PathVariable("lec_id") String lec_id,
                                            @PathVariable("req_id") String req_id,
                                            @RequestParam Map<String, String> allReqParams) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // เปลี่ยนรูปแบบวันที่ให้ตรงกับ HTML
        // ดึงข้อมูล PDF ที่ต้องการแก้ไขจากฐานข้อมูล
        long existingRequestId = Long.parseLong(req_id);
        RequestOpenCourse existingRequest = requestOpCourseService.getRequestOpenCourseDetail(existingRequestId);
        Date requestDate = new Date();

        if (existingRequest != null) {
            existingRequest.setRequestDate(requestDate);

            existingRequest.setStartRegister(dateFormat.parse(allReqParams.get("startRegister")));
            existingRequest.setEndRegister(dateFormat.parse(allReqParams.get("endRegister")));
            existingRequest.setQuantity(Integer.parseInt(allReqParams.get("quantity")));
            existingRequest.setStartStudyDate(dateFormat.parse(allReqParams.get("startStudyDate")));
            existingRequest.setEndStudyDate(dateFormat.parse(allReqParams.get("endStudyDate")));
            existingRequest.setStudyDay(allReqParams.get("display_for_submit"));

            String startStudyTime = allReqParams.get("start_study_time");
            String endStudyTime = allReqParams.get("end_study_time");
            String studyTime = startStudyTime +","+ endStudyTime;
            existingRequest.setStudyTime(studyTime);

            existingRequest.setType_learn(allReqParams.get("type_learn"));
            existingRequest.setType_teach(allReqParams.get("type_teach"));
            existingRequest.setApplicationResult(dateFormat.parse(allReqParams.get("applicationResult")));

            String cId = allReqParams.get("cId");
            System.out.println("cId : " + cId);
            Course course = courseService.getCourseById(cId);
//            Course course = courseService.getCourseById(allReqParams.get("cId"));
            existingRequest.setCourse(course);

            if (course.getFee() != 0){
                existingRequest.setStartPayment(dateFormat.parse(allReqParams.get("startPayment")));
                existingRequest.setEndPayment(dateFormat.parse(allReqParams.get("endPayment")));
            }
            existingRequest.setRequestStatus("รอดำเนินการ");

            String type_learn = allReqParams.get("type_learn");
            if (Objects.equals(type_learn, "เรียนในสถานศึกษา")){
                existingRequest.setLinkMooc(null);
                existingRequest.setLocation(allReqParams.get("location"));
            } else if (Objects.equals(type_learn, "เรียนออนไลน์")) {
                existingRequest.setLocation(null);
                existingRequest.setLinkMooc(allReqParams.get("link_mooc"));
            }else {
                existingRequest.setLocation(allReqParams.get("location"));
                existingRequest.setLinkMooc(allReqParams.get("link_mooc"));
            }
            Session session = sessionFactory.getCurrentSession();
            RequestOpenCourse mergedRequestOpenCourse = (RequestOpenCourse) session.merge(existingRequest);
            requestOpCourseService.updateRequestOpenCourse(mergedRequestOpenCourse);

        }
//        String lec_id = existingRequest.getLecturer().getUsername();
        return "redirect:/lecturer/"+ lec_id +"/list_request_open_course";
    }
    //******************************************************************************//

    //***************************Cancel Course Detail***********************************//
    @GetMapping("/{lec_id}/{roc_id}/cancel_request_open_course")
    public String doCancelCourseDetail(@PathVariable("lec_id")String lec_id,@PathVariable("roc_id") long roc_id) throws IOException {
        //ถ้ายกเลิกหลักสูตรจะทำยังไงกับคนสมัคร
        List<Register> registers = requestOpCourseService.checkRegisterToDelete(roc_id);
//        if (registers.size() == 0){
            RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
            //Course course = courseService.getCourseById(requestOpenCourse.getCourse().getCourse_id());
            requestOpenCourse.setRequestStatus("ถูกยกเลิก");
            requestOpenCourse.getCourse().setStatus("ยังไม่เปิดสอน");
            requestOpCourseService.updateRequestOpenCourse(requestOpenCourse);
//        }else {
//            // ส่งพารามิเตอร์ "error" ใน URL เพื่อระบุว่าเกิดข้อผิดพลาด
//            return "redirect:/lecturer/" + lec_id + "/list_request_open_course?error=true";
//        }
        return "redirect:/lecturer/"+ lec_id +"/list_approve_request_open_course";
    }
    @GetMapping("/{lec_id}/{roc_id}/delete_request_open_course")
    public String doDeleteCourseDetail(@PathVariable("lec_id")String lec_id,@PathVariable("roc_id") long roc_id) throws IOException {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        requestOpCourseService.deleteRequestOpenCourse(roc_id,lec_id);
        //แก้ไขตาราง Course
        Course course = courseService.getCourseById(requestOpenCourse.getCourse().getCourse_id());
        course.setStatus("ยังไม่เปิดสอน");
        courseService.updateCourse(course);
        return "redirect:/lecturer/"+ lec_id +"/list_approve_request_open_course";
    }
    //**********************************************************************************//

    //*************************List Approved Course ต้องเพิ่ม หรือป่าว***************************//
//    @GetMapping("/{lecturer_id}/list_Approved_request_open_course")
//    public String getListApprovedCourseDetail(@PathVariable("lecturer_id") String lecturer_id,Model model) {
//        model.addAttribute("title", "รายการ");
//        model.addAttribute("lecturer_id", lecturer_id);
//        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCoursesByLecturerId(lecturer_id));
//        return null;
//    }
    //**********************************************************************//

    //**********************List Members*********************//
    @GetMapping("/{lecturer_id}/{request_id}/list_member_to_approve")
    public String getListMembers(@PathVariable("lecturer_id") String lecturer_id,@PathVariable("request_id") long request_id , Model model) {
        List<Register> register = registerService.getRegisterByRequestIdAndPayStatusAndApprove(request_id);
        model.addAttribute("title","TEST");
        Date currentDate = new Date();
        List<Receipt> list_receipt = registerService.getReceipt();
        model.addAttribute("receipt",list_receipt);
        model.addAttribute("currentDate",currentDate);
        model.addAttribute("registers",register);
        model.addAttribute("lecturer_id",lecturer_id);
        model.addAttribute("request_name",requestOpCourseService.getRequestOpenCourseDetail(request_id));
        return "lecturer/list_member_approve_course";
    }
    //***********************************************************//

    //**************************getPrintListMember() IReport*******************//
    @GetMapping("/{request_id}/downloadExcel")
    public void downloadExcel(HttpServletResponse response, @PathVariable long request_id) throws IOException {
        // ดึงข้อมูลจาก Service หรือ Repository
        List<Register> register = registerService.getRegisterByRequestIdAndApprove(request_id);
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(request_id);

        // โหลดไฟล์ Excel โครงที่มีอยู่แล้ว
        FileInputStream inputStream = new FileInputStream(ImgPath.pathUploads + "/excel/register_data.xlsx");
//        Workbook workbook = new XSSFWorkbook(inputStream);
        Workbook workbook = new XSSFWorkbook(inputStream);
        inputStream.close();
        // สร้าง Workbook Excel
        Sheet sheet = workbook.getSheet("Sheet1");
        int rowNum = 8;
        int i = 1;
        // สร้าง DataFormat สำหรับรูปแบบวันที่ "dd/MM/yyyy"
        DataFormat dateFormat = workbook.createDataFormat();
        CellStyle dateCellStyle = workbook.createCellStyle();
        dateCellStyle.setDataFormat(dateFormat.getFormat("dd/MM/yyyy"));

        Row rowTitle = sheet.createRow(4);
        rowTitle.createCell(1).setCellValue(requestOpenCourse.getCourse().getName());
        for (Register reg : register) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(1).setCellValue(i++);
            row.createCell(2).setCellValue(reg.getMember().getIdcard());
            row.createCell(3).setCellValue(reg.getMember().getFirstName() +"  "+ reg.getMember().getLastName());
            row.createCell(4).setCellValue(reg.getMember().getTel());
            row.createCell(5).setCellValue(reg.getRegister_date());
            row.getCell(5).setCellStyle(dateCellStyle);
            // เพิ่มคอลัมน์อื่น ๆ ตามที่ต้องการ
        }

        String fileName = requestOpenCourse.getRequest_id()+"_"+requestOpenCourse.getCourse().getCourse_id();

        // ตั้งค่า Response Header
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename="+fileName+".xlsx");

        // ส่งไฟล์ Excel กลับไปยังผู้ใช้
        workbook.write(response.getOutputStream());
        workbook.close();
    }

    //*********************************************************************//

    //******************Edit Study Result*****************//
    @PostMapping(path = "/{request_id}/update_Status_Member_Result/{register_id}")
    public String doEditStudyResult(
            @PathVariable("request_id") long request_id,
            @PathVariable("register_id") long register_id,
            @RequestParam Map<String, String> allReqParams) throws ParseException {

        String studyResult = allReqParams.get("studyResult");
        Register register = registerService.getRegisterByRegisterId(register_id);
        // ตรวจสอบค่า studyResult และดำเนินการตามที่คุณต้องการ
        if ("ผ่านหลักสูตร".equals(studyResult)) {
            register.setStudy_result("ผ่าน");
        } else if ("ไม่ผ่านหลักสูตร".equals(studyResult)) {
            register.setStudy_result("ไม่ผ่าน");
        }
        String lec_id = register.getRequestOpenCourse().getLecturer().getUsername();
        registerService.updateRegister(register);

        return "redirect:/lecturer/" +lec_id+"/"+ request_id + "/list_member_to_approve";
    }
    //******************************************************//

    //**************************View Sample Certificate*******************//
    @GetMapping("/{lecturer_id}/{request_id}/view_sample_certificate")
    public String getSampleCertificate(@PathVariable("lecturer_id") String lecturer_id,@PathVariable("request_id") long request_id , Model model) {
        model.addAttribute("request",requestOpCourseService.getRequestOpenCourseDetail(request_id));
        return "lecturer/view_sample_certificate";
    }
    //*********************************************************************//

    //***********************Upload Signature******************************//
    @PostMapping (path="/{lec_id}/{req_id}/update_signature")
    public String doUpdateSignature(@PathVariable("lec_id") String lec_id,
                                    @PathVariable("req_id") String req_id,
                                    @RequestParam(value = "original_signature", required = false) String original_signature,
                                    @RequestParam("signature") MultipartFile signature,
                                    @RequestParam Map<String, String> allReqParams) throws ParseException {
        // ดึงข้อมูล PDF ที่ต้องการแก้ไขจากฐานข้อมูล
        long existingRequestId = Long.parseLong(req_id);
        RequestOpenCourse existingRequest = requestOpCourseService.getRequestOpenCourseDetailToUpdate(existingRequestId,lec_id);
        try {
            // ถ้ามีการอัพโหลดไฟล์ใหม่
            if (!signature.isEmpty()) {
                String uploadPathSIG = ImgPath.pathUploads + "/request_open_course/signature/";
                if(original_signature == null){
                    // กำหนด path ที่จะบันทึกไฟล์
                    // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
                    Path directoryPathSIG = Paths.get(uploadPathSIG);
                    Files.createDirectories(directoryPathSIG);

//                    String originalImgFileName = signature.getOriginalFilename();
//                    String fileImgExtension = getFileExtension(originalImgFileName);

                    String imgOriginalFileName = signature.getOriginalFilename();
                    String imgFileExtension = getFileExtension(imgOriginalFileName);
                    String signature_img = "";
                    int maxIdImgFile = requestOpCourseService.getSignatureCourseMaxId(); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด
                    // สร้างรหัสไฟล์ใหม่ในรูปแบบ "SIG0001", ...
                    signature_img = String.format("SIG%04d%s", ++maxIdImgFile, imgFileExtension);
                    Path imgFilePath = Paths.get(uploadPathSIG, signature_img);
                    Files.write(imgFilePath, signature.getBytes());
                    existingRequest.setSignature(signature_img);
                    requestOpCourseService.updateRequestOpenCourse(existingRequest);
                }
                    // ผู้ใช้ต้องการแก้ไขรูปภาพเท่านั้น
                    // ดำเนินการอัพโหลดรูปภาพใหม่
                    // ลบรูปเดิม (ถ้ามี)
                    else {
                    // กำหนด path ที่จะบันทึกไฟล์
                    // ถ้ามีการอัพโหลดไฟล์ใหม่
                        if (!signature.isEmpty()) {
                            // ลบไฟล์ PDF เดิม (ถ้ามี)
                            Path path1 = Paths.get(uploadPathSIG, original_signature);
                            if (original_signature != null) {
                                if (Files.exists(path1)) {
                                    Files.delete(path1);
                                }
                            }

                            // บันทึกไฟล์ใหม่
                            Files.write(path1, signature.getBytes());

                            // อัพเดตข้อมูลในฐานข้อมูล
                            assert existingRequest != null;
                            existingRequest.setSignature(original_signature);
                            requestOpCourseService.updateRequestOpenCourse(existingRequest);
                        } else {
                            // ไม่มีการอัพโหลดไฟล์ใหม่ แต่อาจมีการอัพเดตข้อมูลอื่น ๆ ที่ต้องการทำในกรณีนี้
                            requestOpCourseService.updateRequestOpenCourse(existingRequest);
                        }
                    }
            } else {
                // ไม่มีการอัพโหลดไฟล์ใหม่ แต่อาจมีการอัพเดตข้อมูลอื่น ๆ ที่ต้องการทำในกรณีนี้
                requestOpCourseService.updateRequestOpenCourse(existingRequest);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
//        String lec_id = existingRequest.getLecturer().getUsername();
        return "redirect:/lecturer/"+lec_id+"/"+req_id+"/view_sample_certificate";
    }
    //*********************************************************************//

    //*********************Add Course Activity News*********************************//
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
    public String addCourseActivityNews(@PathVariable("lec_id") String lec_id,
                                        @PathVariable("roc_id") long roc_id,
                                        @RequestParam("ac_img") MultipartFile[] ac_img,
                                        @RequestParam Map<String, String> allReqParams) throws ParseException {
        try {
            List<String> newFileNames = new ArrayList<>();

            Date ac_date =  new Date();
            String ac_name = allReqParams.get("ac_name");
            String ac_detail = allReqParams.get("ac_detail");
            String ac_type = "ข่าวสารประจำหลักสูตร";
            RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
            Lecturer lecturer = lecturerService.getLecturerById(lec_id);
//            int maxIdImgFile = courseService.getImgCourseMaxId(course_type); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด
            int latestId = activityService.getActivityMaxId(ac_type); // Get the latest id from the database

            int count = 1;
            for (MultipartFile img : ac_img) {
                String folderName = String.format("AC%03d", latestId+1);
                String uploadPath = ImgPath.pathUploads + "/activity/private/"+folderName+"/";
                Path directoryPath = Paths.get(uploadPath);
                Files.createDirectories(directoryPath);

                String originalFileName = img.getOriginalFilename();
                String fileExtension = getFileExtension(originalFileName);

                String formattedId = String.format("%02d", latestId+1);
                String formattedSequence = String.format("%04d", count);
                String newFileName = String.format("IMG_%s_%s%s", formattedId, formattedSequence, fileExtension);
                Path filePath = Paths.get(uploadPath, newFileName);
                Files.write(filePath, img.getBytes());

                newFileNames.add(newFileName);
                count++;
            }

            ObjectMapper objectMapper = new ObjectMapper();
            String imgNamesJson = objectMapper.writeValueAsString(newFileNames); // Convert the list to JSON

            Activity public_activity_add = new Activity(ac_name,ac_date,ac_detail,ac_type,imgNamesJson,requestOpenCourse,lecturer);
//            Session session = sessionFactory.getCurrentSession();
            activityService.addActivityNews(public_activity_add);
            // ใช้ session.merge() เพื่อรวมหรืออัปเดตอ็อบเจกต์ลงใน session
//            Activity mergedActivity = (Activity) session.merge(public_activity_add);

            // เพิ่มกิจกรรมเข้าสู่ระบบโดยใช้อ็อบเจกต์ที่รวมแล้ว
//            activityService.addActivityNews(mergedActivity);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/lecturer/"+roc_id+"/list_course_activity_news";
    }
    //**********************************************************************************************//

    //**************************ต้องสร้างเมททอด List Course Activity News****************************//
    @GetMapping("/{roc_id}/list_course_activity_news")
    public String getListCourseActivityNews(Model model, @PathVariable("roc_id") long roc_id) {
        model.addAttribute("list_activity",activityService.getActivityDetailByCourseId(roc_id));
        model.addAttribute("request_name",requestOpCourseService.getRequestOpenCourseDetail(roc_id));
        return "lecturer/list_course_activity";
    }
    //*********************************************************************************************//

    //*************************หลังจาก List แล้วก็เข้าเมทตอทนี้เลย update Course Activity*******************************//
    //*************************Edit Course Activity*****************************//
    @GetMapping("/{lec_id}/private/{id}/edit_course_activity_page/{roc_id}")
    public String getListCourseActivityNews(@PathVariable("lec_id") String lec_id,@PathVariable("id") String id,@PathVariable("roc_id") long roc_id, Model model) {
        Activity activity = activityService.getActivityDetailToUpdate(id,lec_id);
        model.addAttribute("title", "แก้ไข" + Activity_title + "ทั่วไป");
        model.addAttribute("activities", activity);
        model.addAttribute("request_id", roc_id);
        return "lecturer/edit_Course_Activity";
    }

    @PostMapping (path="/{lec_id}/{id}/update_course_add_activity")
    public String doEditCourseActivity(@PathVariable("lec_id") String lec_id,
                                       @PathVariable("id") String ac_id,
                                       @RequestParam("ac_img") MultipartFile[] imgs,
                                       @RequestParam Map<String, String> allReqParams) throws ParseException {
//        long existingActivityId = Long.parseLong(ac_id);
        Activity activity = activityService.getActivityDetailToUpdate(ac_id,lec_id);
        try {
            List<String> newFileNames = new ArrayList<>();

            // เรียกดูข้อมูลรูปภาพที่ต้องการแก้ไข
            Activity existingActivity = activityService.getActivityDetailToUpdate(ac_id,lec_id);
            String activity_id = existingActivity.getAc_id();
            activity_id = activity_id.replace("AP", "").replace("AC", "");
            int maxNumericId = Integer.parseInt(activity_id);
            String existingActivityImg = existingActivity.getImg();
            List<String> existingImgNames = new ObjectMapper().readValue(existingActivityImg, ArrayList.class);
            System.out.println("IMG : " + imgs.length);
            String checkfileExtension = "";
            String status = "pass";

            if(imgs.length == 1){
                for (MultipartFile img : imgs) {
                    String originalFileName = img.getOriginalFilename();
                    checkfileExtension = getFileExtension(originalFileName);
                    System.out.println("Check : " + checkfileExtension);
                }
                if (!checkfileExtension.equals("")){
                    status = "pass";
                }else {
                    status = "null";
                }
            }
            if (status.equals("pass")){
                // ลบข้อมูลในฐานข้อมูลก่อน
                existingImgNames.clear();
                // ลบข้อมูลเดิมก่อน
                String deletePath = ImgPath.pathUploads + "/activity/private/"+existingActivity.getAc_id()+"/";
//            String deletePath = ImgPath.pathImg + "/activity/public/public_activity"+maxNumericId+"/";
                Path deletedirectoryPath = Paths.get(deletePath);


                if (Files.isDirectory(deletedirectoryPath)) {
                    // ลบไดเร็กทอรีและเนื้อหาภายใน
                    Files.walk(deletedirectoryPath)
                            .sorted(Comparator.reverseOrder())
                            .map(Path::toFile)
                            .forEach(File::delete);
                } else {
                    // ลบไฟล์
                    Files.delete(deletedirectoryPath);
                }

                // เพิ่มข้อมูลใหม่
                int count = 1;
                for (MultipartFile img : imgs) {
                    String uploadPath = ImgPath.pathUploads + "/activity/private/"+existingActivity.getAc_id()+"/";
                    Path directoryPath = Paths.get(uploadPath);
                    Files.createDirectories(directoryPath);

                    String originalFileName = img.getOriginalFilename();
                    String fileExtension = getFileExtension(originalFileName);

                    String formattedId = String.format("%02d", maxNumericId);
                    String formattedSequence = String.format("%04d", count);
                    String newFileName = String.format("IMG_%s_%s%s", formattedId, formattedSequence, fileExtension);
                    Path filePath = Paths.get(uploadPath, newFileName);
                    Files.write(filePath, img.getBytes());

                    newFileNames.add(newFileName);
                    count++;
                }

                existingImgNames.addAll(newFileNames); // เพิ่มชื่อรูปภาพใหม่ลงในรายการรูปภาพเดิม

                ObjectMapper objectMapper = new ObjectMapper();
                String imgNamesJson = objectMapper.writeValueAsString(existingImgNames); // แปลงรายการรูปภาพใหม่เป็น JSON
                existingActivity.setImg(imgNamesJson);
            }

            // อัพเดตรายละเอียดและรายการรูปภาพในฐานข้อมูล
            existingActivity.setName(allReqParams.get("ac_name"));
            existingActivity.setDetail(allReqParams.get("ac_detail"));
            activityService.updateActivity(existingActivity);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/lecturer/"+activity.getRequestOpenCourse().getRequest_id()+"/list_course_activity_news";
    }
    //*****************************************************************************//

    //***********************Delete Course Activity News***********************//
    @GetMapping("/{lec_id}/{id}/delete")
    public String doDeleteCourseActivityNews(@PathVariable("lec_id") String lec_id,@PathVariable("id") String id) throws IOException {
        Activity activity = activityService.getActivityDetail(id);
        String deletePath = ImgPath.pathUploads + "/activity/private/"+activity.getAc_id()+"/";
        Path deletedirectoryPath = Paths.get(deletePath);
        if (Files.isDirectory(deletedirectoryPath)) {
            // ลบไดเร็กทอรีและเนื้อหาภายใน
            Files.walk(deletedirectoryPath)
                    .sorted(Comparator.reverseOrder())
                    .map(Path::toFile)
                    .forEach(File::delete);
        } else {
            // ลบไฟล์
            Files.delete(deletedirectoryPath);
        }
        activityService.deleteCourseActivity(id,lec_id);
        return "redirect:/lecturer/"+activity.getRequestOpenCourse().getRequest_id()+"/list_course_activity_news";
    }
    //****************************************************************************//









    
    //******************ไม่ดูแล้ว แก้ไขเลย*******************************//
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
    //*******************************************************************//
    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
    }

//    @PostMapping("/update_roc")
//    public String updateRequestOpCourse(@ModelAttribute("request_open_course") RequestOpenCourse requestOpenCourse) {
//        System.out.println(requestOpenCourse.getRequest_id());
//        return "redirect:list_request_open_course";
//    }

    //**********************ไม่ดูแล้ว แก้ไขเลย**************************************//
    @GetMapping("/{lec_id}/{ac_id}/view_course_activity_page/{roc_id}")
    public String showCourseActivityDetail(@PathVariable("lec_id") String lec_id,@PathVariable("ac_id") String ac_id,@PathVariable("roc_id") long roc_id, Model model) {
        Activity activity = activityService.getActivityDetailToUpdate(ac_id,lec_id);
        model.addAttribute("title", "รายละเอียด" + Activity_title + "ทั่วไป");
        model.addAttribute("activities", activity);
        model.addAttribute("request_id", roc_id);
        return "lecturer/view_detail_course_activity";
    }
    //**********************************************************************//


}

