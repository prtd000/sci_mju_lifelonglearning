package lifelong.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import lifelong.model.*;
import lifelong.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
//import com.fasterxml.jackson.databind.ObjectMapper;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.util.*;

import org.springframework.web.multipart.MultipartFile;
import utils.ImgPath;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
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

    //**************Add Course***********//
    @GetMapping("/{admin_id}/add_course")
    public String showFormAddCourse(Model model, @PathVariable String admin_id) {
        model.addAttribute("title", "เพิ่ม" + title);
        model.addAttribute("majors", majorService.getMajors());
        model.addAttribute("add_course", new Course());
        model.addAttribute("admin_id",admin_id);
        return "admin/addCourse";
    }

    @PostMapping(path = "/{admin_id}/save")
    public String doAddCourse(@RequestParam Map<String, String> allReqParams,
                              @RequestParam("course_img") MultipartFile img,
                              @RequestParam("course_file") MultipartFile pdf,
                              @RequestParam("course_objectives[]") String[] courseObjectives,
                              @PathVariable("admin_id") String admin_id) throws ParseException {
        String course_name = allReqParams.get("course_name");
        String certificateName = allReqParams.get("certificateName");
        String course_principle = allReqParams.get("course_principle");
//        String course_object = allReqParams.get("course_object");
        String course_object = "";
        for (String objective : courseObjectives) {
            System.out.println("วัตถุประสงค์: " + objective);
            course_object = course_object +"$%"+ objective;
            // ทำตามการจัดการที่คุณต้องการ เช่น บันทึกข้อมูลลงฐานข้อมูล
        }
        int course_totalHours = Integer.parseInt(allReqParams.get("course_totalHours"));
        String course_targetOccupation = allReqParams.get("course_targetOccupation");
        double course_fee = Double.parseDouble(allReqParams.get("course_fee"));
        String course_status = "ยังไม่เปิดสอน";
        String course_linkMooc = allReqParams.get("course_linkMooc");

        String course_type = allReqParams.get("course_type");

        Major major = majorService.getMajorDetail(allReqParams.get("major_id"));

        try {

            // เพิ่ม รูปภาพ
            // กำหนด path ที่จะบันทึกไฟล์
            String uploadPathIMG = ImgPath.pathImg + "/course_img/";
            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
            Path directoryPathIMG = Paths.get(uploadPathIMG);
            Files.createDirectories(directoryPathIMG);

//            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
//            // รูปภาพ
//            Path directoryPathIMG = Paths.get(uploadPathIMG);
//            Files.createDirectories(directoryPathIMG);
//
//            // ดึงนามสกุลไฟล์จากชื่อไฟล์
//            // รูปภาพ
//            String originalImgFileName = img.getOriginalFilename();
//            String fileImgExtension = getFileExtension(originalImgFileName);
//
            int maxIdImgFile = courseService.getImgCourseMaxId(course_type); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด
//
//            String course_img = "";
//            if (Objects.equals(course_type, "หลักสูตรอบรมระยะสั้น")){
//                // สร้างรหัสไฟล์ใหม่ในรูปแบบ "C_IMG0001", "C_IMG0002", ...
//                course_img = String.format("C_IMG%04d%s", ++latestFileCount, fileImgExtension);
//            }else {
//                // สร้างรหัสไฟล์ใหม่ในรูปแบบ "N_IMG0001", "N_IMG0002", ...
//                course_img = String.format("N_IMG%04d%s", ++latestFileCount, fileImgExtension);
//            }
//            // บันทึกไฟล์ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
//            Path imgPath = Paths.get(uploadPathIMG, course_img);
//            Files.write(imgPath, img.getBytes());

//            // เพิ่ม PDF
//            // กำหนด path ที่จะบันทึกไฟล์
            String uploadPathPDF = ImgPath.pathImg + "/course_pdf/";
            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
            Path directoryPathPDF = Paths.get(uploadPathPDF);
            Files.createDirectories(directoryPathPDF);
//
//            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
//            Path directoryPathPDF = Paths.get(uploadPathPDF);
//            Files.createDirectories(directoryPathPDF);
//
//            // ดึงนามสกุลไฟล์จากชื่อไฟล์
//            // PDF
//            String originalPdfFileName = pdf.getOriginalFilename();
//            String filePdfExtension = getFileExtension(originalPdfFileName);
//
//            String course_pdf = String.format("PDF_%04d%s", ++latestFileCount, filePdfExtension);
//
//            // บันทึกไฟล์ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
//            Path pdfPath = Paths.get(uploadPathPDF, course_pdf);
//            Files.write(pdfPath, pdf.getBytes());

            // บันทึกไฟล์รูปภาพ
            String imgOriginalFileName = img.getOriginalFilename();
            String imgFileExtension = getFileExtension(imgOriginalFileName);
            String course_img = "";
            if (Objects.equals(course_type, "หลักสูตรอบรมระยะสั้น")){
                // สร้างรหัสไฟล์ใหม่ในรูปแบบ "C_IMG0001", "C_IMG0002", ...
                course_img = String.format("C_IMG%04d%s", ++maxIdImgFile, imgFileExtension);
            }else {
                // สร้างรหัสไฟล์ใหม่ในรูปแบบ "N_IMG0001", "N_IMG0002", ...
                course_img = String.format("N_IMG%04d%s", ++maxIdImgFile, imgFileExtension);
            }
            Path imgFilePath = Paths.get(uploadPathIMG, course_img);
            Files.write(imgFilePath, img.getBytes());

            // บันทึกไฟล์ PDF
            int maxIdPDFFile = courseService.getCoursePDFMaxId(); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด
            String pdfOriginalFileName = pdf.getOriginalFilename();
            String pdfFileExtension = getFileExtension(pdfOriginalFileName);
            String course_pdf = String.format("PDF_%04d%s", ++maxIdPDFFile, pdfFileExtension);
            Path pdfFilePath = Paths.get(uploadPathPDF, course_pdf);
            Files.write(pdfFilePath, pdf.getBytes());

            // บันทึก path ไปยังฐานข้อมูล
            Course course_add = new Course(course_name, certificateName, course_img, course_principle, course_object, course_totalHours,
                    course_targetOccupation, course_fee, course_pdf, course_status, course_linkMooc, course_type, major);
            courseService.doAddCourse(course_add);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/course/"+admin_id+"/list_all_course";
    }
    //***********************************************//

    //**********Approve Request Open Course*******************//
    @GetMapping("/{admin_id}/view_request_open_course/{request_id}")
    public String getListRequestOpenCourse(@PathVariable("request_id") long request_id,@PathVariable("admin_id") String admin_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(request_id);
        model.addAttribute("title", "ดูข้อมูลการร้องขอ");
        model.addAttribute("ROC_detail", requestOpenCourse);
        model.addAttribute("admin_id",admin_id);
        return "admin/view_request_open_course_by_admin";
    }

    @PostMapping(path = "/{admin_id}/view_request_open_course/{request_id}/approve")
    public String doApproveRequest(@PathVariable("request_id") long roc_id,
                                   @PathVariable("admin_id") String admin_id,
                                   @RequestParam Map<String, String> allReqParams) throws ParseException, IOException {
        RequestOpenCourse existingRequestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        if (existingRequestOpenCourse != null) {
            existingRequestOpenCourse.setRequestStatus("ผ่าน");

            int round = requestOpCourseService.getRequestCourseRoundMaxId(existingRequestOpenCourse.getCourse().getCourse_id());
            existingRequestOpenCourse.setRound(++round);
            requestOpCourseService.updateRequestOpenCourse(existingRequestOpenCourse);

            // แก้ไขคำร้องขออื่นๆที่รอขอมาเหมือนกันแต่ยังไม่ผ่าน
            List<RequestOpenCourse> requestOpenCourses = requestOpCourseService.checkRequestOpenCourseByCourseIdToUnApprove(existingRequestOpenCourse.getCourse().getCourse_id());
            for (RequestOpenCourse requestOpenCourse : requestOpenCourses) {
                // แก้ไขสถานะ Request Open Course อื่นๆ
                requestOpenCourse.setRequestStatus("ไม่ผ่าน");
                requestOpCourseService.updateRequestOpenCourse(requestOpenCourse);
            }
            //แก้ไขตาราง Course
            Course course = courseService.getCourseById(existingRequestOpenCourse.getCourse().getCourse_id());
            course.setStatus("เปิดสอน");
            courseService.updateCourse(course);
        }
        return "redirect:/course/"+admin_id+"/list_all_course";
    }

    @PostMapping(path = "/{admin_id}/view_request_open_course/{request_id}/cancel")
    public String cancelRequestOpenCourse(@PathVariable("request_id") long roc_id,
                                          @PathVariable("admin_id") String admin_id,
                                          @RequestParam Map<String, String> allReqParams) throws ParseException {
        // เป็นการลบข้อมูลไปเลย
//        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
//        String lec_id = requestOpenCourse.getLecturer().getUsername();
//        requestOpCourseService.deleteRequestOpenCourse(roc_id,lec_id);

        // เป็นการแก้ไขข้อมูล
        RequestOpenCourse existingRequestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        if (existingRequestOpenCourse != null) {
            existingRequestOpenCourse.setRequestStatus("ไม่ผ่าน");
            requestOpCourseService.updateRequestOpenCourse(existingRequestOpenCourse);
        }
        return "redirect:/course/"+admin_id+"/list_all_course";
    }
    //******************************************************//

    //**********List All Course************//
    @GetMapping("/{admin_id}/list_all_course")
    public String getListAllCourse(Model model ,@PathVariable("admin_id") String admin_id) {
        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("courses", courseService.getCourses());
//        model.addAttribute("courses", courseService.getCoursesAndRequests());
        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCourses());
        model.addAttribute("list_activities", activityService.getPublicActivity());
        model.addAttribute("admin_id",admin_id);
        return "admin/listAllCourse";
    }
    //**********************************************//

    //**************Edit Course*******************//
    @GetMapping("/{id}/edit_course")
    public String getCourse(@PathVariable("id") String id, Model model) {
        Course course = courseService.getCourseById(id);
        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("majors", majorService.getMajors());
        model.addAttribute("course", course);
        return "admin/editCourse";
    }

    @PostMapping(path = "/{admin_id}/{id}/update_edit_course")
    public String doEditCourse(@PathVariable("admin_id") String admin_id,
                               @PathVariable("id") String course_id,
                               @RequestParam("course_objectives[]") String[] courseObjectives,
                               @RequestParam("course_img") MultipartFile course_img,
                               @RequestParam(value = "original_img", required = false) String original_img,
                               @RequestParam("course_file") MultipartFile course_file,
                               @RequestParam(value = "original_file", required = false) String original_file,
                               @RequestParam Map<String, String> allReqParams) throws ParseException {
        Course existingCourse = courseService.getCourseById(course_id);
        if (existingCourse != null) {
            existingCourse.setName(allReqParams.get("course_name"));
            existingCourse.setCertificateName(allReqParams.get("certificateName"));
//            existingCourse.setImg(allReqParams.get("course_img"));
            existingCourse.setPrinciple(allReqParams.get("course_principle"));
            String course_object = "";
            for (String objective : courseObjectives) {
                System.out.println("วัตถุประสงค์: " + objective);
                course_object = course_object +"$%"+ objective;
                // ทำตามการจัดการที่คุณต้องการ เช่น บันทึกข้อมูลลงฐานข้อมูล
            }
            existingCourse.setObject(course_object);
            existingCourse.setTotalHours(Integer.parseInt(allReqParams.get("course_totalHours")));
            existingCourse.setTargetOccupation(allReqParams.get("course_targetOccupation"));
            existingCourse.setFee(Double.parseDouble(allReqParams.get("course_fee")));
//            existingCourse.setFile(allReqParams.get("course_file"));
            existingCourse.setLinkMooc(allReqParams.get("course_linkMooc"));
            existingCourse.setCourse_type(allReqParams.get("course_type"));
            existingCourse.setMajor(majorService.getMajorDetail(allReqParams.get("major_id")));

            try {
                // กำหนด path ที่จะบันทึกไฟล์
                String imgPath = ImgPath.pathImg + "/course_img/";
                String pdfPath = ImgPath.pathImg + "/course_pdf/";
                // ถ้ามีการอัพโหลดไฟล์ใหม่
                Path pathIMG = Paths.get(imgPath, original_img);
                Path pathPDF = Paths.get(pdfPath,original_file);
                // ตรวจสอบว่าผู้ใช้ต้องการแก้ไขรูปภาพและ/หรือไฟล์ PDF
                if (!course_img.isEmpty() && !course_file.isEmpty()) {
                    // ผู้ใช้ต้องการแก้ไขทั้งรูปภาพและไฟล์ PDF
                    // ดำเนินการอัพโหลดรูปภาพใหม่
                    // ลบรูปเดิม (ถ้ามี)
                    if (original_img != null) {
                        if (Files.exists(pathIMG)) {
                            Files.delete(pathIMG);
                        }
                    }
                    // บันทึกไฟล์ใหม่ IMG
                    Files.write(pathIMG, course_img.getBytes());
                    // อัพเดตข้อมูลในฐานข้อมูล
                    existingCourse.setImg(original_img);
                    // ดำเนินการอัพโหลดไฟล์ PDF ใหม่
                    // ลบไฟล์ PDF เดิม (ถ้ามี)
                    if (original_file != null) {
                        if (Files.exists(pathPDF)) {
                            Files.delete(pathPDF);
                        }
                    }
                    // บันทึกไฟล์ใหม่ PDF
                    Files.write(pathPDF, course_file.getBytes());
                    // อัพเดตข้อมูลในฐานข้อมูล
                    existingCourse.setFile(original_file);
                    // อัพเดตข้อมูลอื่น ๆ ในฐานข้อมูล (detail, เป็นต้น)
                    courseService.updateCourse(existingCourse);
                } else if (!course_img.isEmpty()) {
                    // ผู้ใช้ต้องการแก้ไขรูปภาพเท่านั้น
                    // ดำเนินการอัพโหลดรูปภาพใหม่
                    // ลบรูปเดิม (ถ้ามี)
                    if (original_img != null) {
                        if (Files.exists(pathIMG)) {
                            Files.delete(pathIMG);
                        }
                    }
                    // บันทึกไฟล์ใหม่ IMG
                    Files.write(pathIMG, course_img.getBytes());
                    // อัพเดตข้อมูลในฐานข้อมูล
                    existingCourse.setImg(original_img);

                    // อัพเดตข้อมูลอื่น ๆ ในฐานข้อมูล (detail, เป็นต้น)
                    courseService.updateCourse(existingCourse);
                } else if (!course_file.isEmpty()) {
                    // ดำเนินการอัพโหลดไฟล์ PDF ใหม่
                    // ลบไฟล์ PDF เดิม (ถ้ามี)
                    if (original_file != null) {
                        if (Files.exists(pathPDF)) {
                            Files.delete(pathPDF);
                        }
                    }
                    // บันทึกไฟล์ใหม่ PDF
                    Files.write(pathPDF, course_file.getBytes());
                    // อัพเดตข้อมูลในฐานข้อมูล
                    existingCourse.setFile(original_file);

                    // อัพเดตข้อมูลอื่น ๆ ในฐานข้อมูล (detail, เป็นต้น)
                    courseService.updateCourse(existingCourse);
                } else {
                    // ไม่มีการแก้ไขรูปภาพและไฟล์ PDF
                    // อัพเดตข้อมูลอื่น ๆ ในฐานข้อมูล (detail, เป็นต้น)
                    courseService.updateCourse(existingCourse);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "redirect:/course/"+admin_id+"/list_all_course";
    }
    //************************************************************//

    //*****************Approve Member to Course******************//
    @GetMapping("/{roc_id}/list_member_to_course")
    public String showListMemberToRequestCourse(@PathVariable("roc_id") long roc_id, Model model) {
        List<Register> register = registerService.getRegisterByRequestId(roc_id);
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        List<Receipt> list_receipt = registerService.getReceipt();
        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("register_detail", register);
        model.addAttribute("receipt",list_receipt);
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
//    @PostMapping(path = "/{request_id}/{admin_id}/view_payment_detail/{invoice_id}/approve")
//    public String updatePaymentStatus(@PathVariable("request_id") long request_id,
//                                      @PathVariable("admin_id") String admin_id,
//                                      @PathVariable("invoice_id") long invoice_id,
//                                      @RequestParam Map<String, String> allReqParams) throws ParseException {
//        Invoice invoice = paymentService.getInvoiceById(invoice_id);
//        if (invoice != null) {
//            invoice.setApprove_status("ผ่าน");
//            paymentService.updateInvoice(invoice);
//        }
//        return "redirect:/course/"+request_id+"/list_member_to_course";
//    }
    @PostMapping(path = "/{request_id}/{admin_id}/view_payment_detail/{invoice_id}/approve")
    public String updatePaymentStatus(
            @PathVariable("request_id") long request_id,
            @RequestParam Map<String, String> allReqParams,
            @PathVariable String admin_id,
            @PathVariable long invoice_id) throws ParseException {

        String approveResult = allReqParams.get("approveResult");
        Invoice invoice = paymentService.getInvoiceById(invoice_id);
        // ตรวจสอบค่า approveResult และดำเนินการตามที่คุณต้องการ
        if ("ยืนยันการสมัคร".equals(approveResult)) {
            invoice.setApprove_status("ผ่าน");
        } else if ("ยกเลิกการสมัคร".equals(approveResult)) {
            invoice.setApprove_status("ไม่ผ่าน");
        }
        paymentService.updateInvoice(invoice);

        return "redirect:/course/"+request_id+"/list_member_to_course";
    }

    //*******************************************************************//

    //**************Add Activity News************************//
    @GetMapping("/public/add_activity")
    public String showFormAddActivity(Model model) {
        model.addAttribute("title", "เพิ่ม" + title);
//        model.addAttribute("add_public_activity", new Activity());
        return "admin/add_Public_Activity";
    }

    @PostMapping(path = "/{admin_id}/save_public_add_activity")
    public String addActivityNews(@PathVariable("admin_id") String admin_id,
                                  @RequestParam Map<String, String> allReqParams,
                                  @RequestParam("ac_img") MultipartFile[] ac_img) throws ParseException {
        try {
            List<String> newFileNames = new ArrayList<>();

            String ac_name = allReqParams.get("ac_name");
            Date ac_date = new Date();
            String ac_detail = allReqParams.get("ac_detail");
            String ac_type = "ข่าวสารทั่วไป";
//            String ac_img = allReqParams.get("ac_img");
//            int maxIdImgFile = courseService.getImgCourseMaxId(course_type); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด
            int latestId = activityService.getActivityMaxId(ac_type); // Get the latest id from the database

            int count = 1;
            for (MultipartFile img : ac_img) {
                String folderName = String.format("AP%03d", latestId+1);
                String uploadPath = ImgPath.pathImg + "/activity/public/"+folderName+"/";
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

//            AddImg newImg = new AddImg(detail, imgNamesJson);
            Activity public_activity_add = new Activity(ac_name, ac_date, ac_detail, ac_type, imgNamesJson);
            activityService.addActivityNews(public_activity_add);
//            courseService.doAddImg(newImg);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/course/"+admin_id+"/list_all_course";
    }
    //*********************************************************//

    //**********List Activity News******************//
    @GetMapping("/public/list_activity")
    public String getListActivityNews(Model model) {
        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("list_activities", activityService.getPublicActivity());
        return "admin/list_Public_Activity";
    }
    //************************************************//

    //********Edit Activity News ******************//
    @GetMapping("/public/{id}/edit_page")
    public String getListActivityNews(@PathVariable("id") String id, Model model) {
        Activity activity = activityService.getActivityDetail(id);
        model.addAttribute("title", "แก้ไข" + title + "ทั่วไป");
        model.addAttribute("activities", activity);
        return "admin/edit_Public_Activity";
    }

    @PostMapping(path = "/{admin}/{id}/update_public_add_activity")
    public String doEditActivityNews(@PathVariable("id") String ac_id,
                                     @RequestParam("ac_img") MultipartFile[] imgs,
                                     @RequestParam Map<String, String> allReqParams,
                                     @PathVariable String admin) throws ParseException {
        try {
            List<String> newFileNames = new ArrayList<>();

            // เรียกดูข้อมูลรูปภาพที่ต้องการแก้ไข
            Activity existingActivity = activityService.getActivityDetail(ac_id);
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
                String deletePath = ImgPath.pathImg + "/activity/public/"+existingActivity.getAc_id()+"/";
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
                    String uploadPath = ImgPath.pathImg + "/activity/public/"+existingActivity.getAc_id()+"/";
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
        System.out.println("PASS");

        return "redirect:/course/"+admin+"/list_all_course";
    }
    //**********************************************//

    //***************Delete Activity News********************//
    @GetMapping("/{admin_id}/{ac_id}/delete")
    public String doDeleteActivityNews(@PathVariable String ac_id, @PathVariable String admin_id) throws IOException {
        Activity activity = activityService.getActivityDetail(ac_id);
//        String activity_id = activity.getAc_id();
//        activity_id = activity_id.replace("AP", "").replace("AC", "");
//        int maxNumericId = Integer.parseInt(activity_id);
////        System.out.println(maxNumericId);
        // ลบข้อมูลเดิมก่อน
        String deletePath = ImgPath.pathImg + "/activity/public/"+activity.getAc_id()+"/";
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
        activityService.deleteActivity(ac_id);
        return "redirect:/course/"+admin_id+"/list_all_course";
    }
    //*******************************************************//

//    //************************ลบทิ้งมันเกินที่คิดไว้*******************************//
//    @GetMapping("/note_cancel_request_open_course/{request_id}")
//    public String noteCancelRequestOpenCourse(@PathVariable("request_id") long request_id, Model model) {
//        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(request_id);
//        model.addAttribute("ROC_detail", requestOpenCourse);
//        return "admin/note_not_pass_detail";
//    }
//
//    @PostMapping(path = "/note_cancel_request_open_course/{request_id}/cancel")
//    public String cancelRequestOpenCourse(@PathVariable("request_id") long roc_id, @RequestParam Map<String, String> allReqParams) throws ParseException {
//        RequestOpenCourse existingRequestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
//        if (existingRequestOpenCourse != null) {
//            existingRequestOpenCourse.setRequestStatus("ไม่ผ่าน");
//            existingRequestOpenCourse.setNote(allReqParams.get("cancelReason"));
//            requestOpCourseService.updateRequestOpenCourse(existingRequestOpenCourse);
//        }
//        return "redirect:/course/list_all_course";
//    }
//    //*******************************************************//

    //*********************Comment**************************//
    @GetMapping("/{id}/course_detail")
    public String showCourseDetailByAdmin(@PathVariable("id") String id, Model model) {
        Course course = courseService.getCourseDetail(id);
        model.addAttribute("title", "รายละเอียด" + title);
        model.addAttribute("course_detail", course);
        return "admin/course_detail_by_admin";
    }

    @GetMapping("/{admin_id}/view_approve_request_open_course/{id}")
    public String showRequestApproveOpenCourse(@PathVariable("id") long id, Model model, @PathVariable String admin_id) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(id);
        model.addAttribute("title", "แก้ไข" + title);
        model.addAttribute("RAOC_detail", requestOpenCourse);
        return "admin/view_Approve_request_open_course_by_admin";
    }
    //*******************************************************//

//    @GetMapping("/{roc_id}/list_course_activity")
//    public String listCourseActivity(Model model, @PathVariable("roc_id") long roc_id) {
//        model.addAttribute("title", "รายการ" + title);
//        model.addAttribute("list_activities", activityService.getPublicActivity());
//        return "admin/list_Public_Activity";
//    }


    @GetMapping("/add_img")
    public String addImg(Model model, HttpSession session) {
//        List<AddImg> addImg = courseService.getAddImg();
//        model.addAttribute("list_img",courseService.getAddImg());
//        session.setAttribute("list_img",courseService.getAddImg());
        List<AddImg> imageList = courseService.getAddImg(); // ดึงข้อมูลรูปภาพทั้งหมดจากฐานข้อมูล
        model.addAttribute("list_img", imageList); // ส่งข้อมูลไปยังหน้า JSP
        return "admin/add_img";
    }

    @Autowired
    private ServletContext servletContext;

    //************************** IMG ***********************************//
//    @PostMapping("/addImg")
//    public String addImg(@RequestParam("detail") String detail, @RequestParam("file") MultipartFile file) {
//        try {
//
//            // กำหนด path ที่จะบันทึกไฟล์
//            String uploadPath = ImgPath.pathImg + "/addImg/";
//
//            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
//            Path directoryPath = Paths.get(uploadPath);
//            Files.createDirectories(directoryPath);
//
//            // ดึงนามสกุลไฟล์จากชื่อไฟล์
//            String originalFileName = file.getOriginalFilename();
//            String fileExtension = getFileExtension(originalFileName);
//            int latestFileCount = courseService.getLatestFileCount(); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด
//
//            // สร้างรหัสไฟล์ใหม่ในรูปแบบ "IMG_0001", "IMG_0002", ...
//            String newFileName = String.format("IMG_%04d%s", ++latestFileCount, fileExtension);
//
//            // บันทึกไฟล์ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
//            Path filePath = Paths.get(uploadPath, newFileName);
//            Files.write(filePath, file.getBytes());
//
//            // บันทึก path ไปยังฐานข้อมูล
//            AddImg newImg = new AddImg(detail, newFileName);
//            courseService.doAddImg(newImg);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return "redirect:/"; // หรือไปยังหน้าที่คุณต้องการ
//    }
    //**********************เพิ่มรูปทีละหลายๆรูป*************************//
//    @PostMapping("/addListImg")
//    public String addImg(@RequestParam("detail") String detail, @RequestParam("files") MultipartFile[] files) {
//        try {
//            String uploadPath = ImgPath.pathImg + "/addImg/";
//            Path directoryPath = Paths.get(uploadPath);
//            Files.createDirectories(directoryPath);
//
//            int latestFileCount = courseService.getLatestFileCount();
//
//            List<String> newFileNames = new ArrayList<>(); // สร้างรายชื่อไฟล์ใหม่
//
//            for (MultipartFile file : files) {
//                String originalFileName = file.getOriginalFilename();
//                String fileExtension = getFileExtension(originalFileName);
//                String newFileName = String.format("IMG_%04d%s", ++latestFileCount, fileExtension);
//                Path filePath = Paths.get(uploadPath, newFileName);
//                Files.write(filePath, file.getBytes());
//
//                newFileNames.add(newFileName); // เพิ่มชื่อไฟล์ในรายชื่อใหม่
//            }
//
//            AddImg newImg = new AddImg(detail, newFileNames); // ส่งรายชื่อไฟล์ใหม่ไปในคอนสตรักเตอร์
//            courseService.doAddImg(newImg);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return "redirect:/"; // หรือไปยังหน้าที่คุณต้องการ
//    }

//    @PostMapping("/addListImg")
//    public String addImg(@RequestParam("detail") String detail, @RequestParam("files") MultipartFile[] files) {
//        try {
//            String uploadPath = ImgPath.pathImg + "/addImg/";
//            Path directoryPath = Paths.get(uploadPath);
//            Files.createDirectories(directoryPath);
//
//            int latestFileCount = courseService.getLatestFileCount();
//
//            List<String> newFileNames = new ArrayList<>();
//            int latestId = courseService.getLatestFileCount(); // Get the latest id from the database
//
//            for (MultipartFile file : files) {
//                String originalFileName = file.getOriginalFilename();
//                String fileExtension = getFileExtension(originalFileName);
//
//                latestId++; // Increment the latestId for each set of images
//
//                for (int i = 1; i <= 3; i++) { // Assuming you have 3 images per id
//                    String formattedId = String.format("%02d", latestId);
//                    String formattedSequence = String.format("%04d", i);
//                    String newFileName = String.format("IMG_%s_%s%s", formattedId, formattedSequence, fileExtension);
//                    Path filePath = Paths.get(uploadPath, newFileName);
//                    Files.write(filePath, file.getBytes());
//
//                    newFileNames.add(newFileName);
//                }
//            }
//
//            ObjectMapper objectMapper = new ObjectMapper();
//            String imgNamesJson = objectMapper.writeValueAsString(newFileNames); // เขียนรายชื่อไฟล์เป็น JSON
//
//            AddImg newImg = new AddImg(detail, imgNamesJson);
//            courseService.doAddImg(newImg);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return "redirect:/"; // หรือไปยังหน้าที่คุณต้องการ
//    }

    @PostMapping("/addListImg")
    public String addImg(@RequestParam("detail") String detail, @RequestParam("files") MultipartFile[] files) {
        try {
            List<String> newFileNames = new ArrayList<>();

            int latestId = courseService.getLatestFileCount(); // Get the latest id from the database

            int count = 1;
            for (MultipartFile file : files) {
                String uploadPath = ImgPath.pathImg + "/addImg/listimg"+(latestId+1)+"/";
                Path directoryPath = Paths.get(uploadPath);
                Files.createDirectories(directoryPath);

                String originalFileName = file.getOriginalFilename();
                String fileExtension = getFileExtension(originalFileName);

                    String formattedId = String.format("%02d", latestId+1);
                    String formattedSequence = String.format("%04d", count);
                    String newFileName = String.format("IMG_%s_%s%s", formattedId, formattedSequence, fileExtension);
                    Path filePath = Paths.get(uploadPath, newFileName);
                    Files.write(filePath, file.getBytes());

                    newFileNames.add(newFileName);
                    count++;
            }

            ObjectMapper objectMapper = new ObjectMapper();
            String imgNamesJson = objectMapper.writeValueAsString(newFileNames); // Convert the list to JSON

            AddImg newImg = new AddImg(detail, imgNamesJson);
            courseService.doAddImg(newImg);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/"; // Redirect to the desired page
    }

    //************************************************************//
    @GetMapping("/editPDF/{list_img_Id}")
    public String showEditListForm(@PathVariable long list_img_Id, Model model) {
        // ดึงข้อมูล PDF จากฐานข้อมูลโดยใช้ pdfId
        AddImg pdf = courseService.getPdfById(list_img_Id);

        // ส่งข้อมูล PDF ไปยังหน้าแก้ไข
        model.addAttribute("pdf", pdf);

        return "admin/edit_img"; // ชื่อหน้าแก้ไขของคุณ
    }

    // สร้างเมธอดใน Controller สำหรับแก้ไขรูปภาพ
    @PostMapping("/editListImg/{list_img_Id}")
    public String editListImg(@RequestParam("detail") String newDetail,
                              @RequestParam("file") MultipartFile[] files, @PathVariable long list_img_Id) {
        try {
            List<String> newFileNames = new ArrayList<>();

            // เรียกดูข้อมูลรูปภาพที่ต้องการแก้ไข
            AddImg existingImg = courseService.getPdfById(list_img_Id);

            String existingImgNamesJson = existingImg.getImgNamesJson();
            List<String> existingImgNames = new ObjectMapper().readValue(existingImgNamesJson, ArrayList.class);
            // ลบข้อมูลในฐานข้อมูลก่อน
            existingImgNames.clear();
            // ลบข้อมูลเดิมก่อน
            String deletePath = ImgPath.pathImg + "/addImg/listimg" + list_img_Id + "/";
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
            for (MultipartFile file : files) {
                String uploadPath = ImgPath.pathImg + "/addImg/listimg" + list_img_Id + "/";
                Path directoryPath = Paths.get(uploadPath);
                Files.createDirectories(directoryPath);

                String originalFileName = file.getOriginalFilename();
                String fileExtension = getFileExtension(originalFileName);

                String formattedId = String.format("%02d", list_img_Id);
                String formattedSequence = String.format("%04d", count);
                String newFileName = String.format("IMG_%s_%s%s", formattedId, formattedSequence, fileExtension);
                Path filePath = Paths.get(uploadPath, newFileName);
                Files.write(filePath, file.getBytes());

                newFileNames.add(newFileName);
                count++;
            }

            existingImgNames.addAll(newFileNames); // เพิ่มชื่อรูปภาพใหม่ลงในรายการรูปภาพเดิม

            ObjectMapper objectMapper = new ObjectMapper();
            String imgNamesJson = objectMapper.writeValueAsString(existingImgNames); // แปลงรายการรูปภาพใหม่เป็น JSON

            // อัพเดตรายละเอียดและรายการรูปภาพในฐานข้อมูล
            existingImg.setDetail(newDetail);
            existingImg.setImgNamesJson(imgNamesJson);
            courseService.updatePDF(existingImg);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/"; // ลิ้งค์ไปยังหน้าที่ต้องการหลังจากการแก้ไข
    }

    //********************* PDF *********************************//
    @PostMapping("/addPDF")
    public String addPDF(@RequestParam("detail") String detail, @RequestParam("file") MultipartFile file) {
        try {

            // กำหนด path ที่จะบันทึกไฟล์
            String uploadPath = ImgPath.pathImg + "/course_pdf/pdf/";

            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
            Path directoryPath = Paths.get(uploadPath);
            Files.createDirectories(directoryPath);

            // ดึงนามสกุลไฟล์จากชื่อไฟล์
            String originalFileName = file.getOriginalFilename();
            String fileExtension = getFileExtension(originalFileName);

            int latestFileCount = courseService.getLatestFileCount(); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด

            // สร้างรหัสไฟล์ใหม่ในรูปแบบ "IMG_0001", "IMG_0002", ...
            String newFileName = String.format("PDF_%04d%s", ++latestFileCount, fileExtension);

            // บันทึกไฟล์ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
            // บันทึกไฟล์ PDF ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
            Path filePath = Paths.get(uploadPath, newFileName);
            Files.write(filePath, file.getBytes());

            // บันทึกเส้นทางไฟล์ในฐานข้อมูล
            AddImg newImg = new AddImg(detail, newFileName);
            courseService.doAddImg(newImg);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/coursr/add_img"; // หรือไปยังหน้าที่คุณต้องการ
    }

    // รับนามสกุลไฟล์จากชื่อไฟล์
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
            return fileName.substring(dotIndex);
        }
        return "";
    }

//    @GetMapping("/editPDF/{pdfId}")
//    public String showEditForm(@PathVariable long pdfId, Model model) {
//        // ดึงข้อมูล PDF จากฐานข้อมูลโดยใช้ pdfId
//        AddImg pdf = courseService.getPdfById(pdfId);
//
//        // ส่งข้อมูล PDF ไปยังหน้าแก้ไข
//        model.addAttribute("pdf", pdf);
//
//        return "admin/edit_img"; // ชื่อหน้าแก้ไขของคุณ
//    }

//    @PostMapping("/editPDF/{pdfId}")
//    public String editPDF(
//            @PathVariable long pdfId,
//            @RequestParam("detail") String detail,
//            @RequestParam("file") MultipartFile file,
//            @RequestParam(value = "existingFileName", required = false) String existingFileName
//    ) {
//        try {
//            // ดึงข้อมูล PDF ที่ต้องการแก้ไขจากฐานข้อมูล
//            AddImg pdfToUpdate = courseService.getPdfById(pdfId);
//            // กำหนด path ที่จะบันทึกไฟล์
//            String uploadPath = ImgPath.pathImg + "/course_pdf/pdf/";
//            // ถ้ามีการอัพโหลดไฟล์ใหม่
//            if (!file.isEmpty()) {
//                // ลบไฟล์ PDF เดิม (ถ้ามี)
//                Path path1 = Paths.get(uploadPath, existingFileName);
//                if (existingFileName != null) {
//                    if (Files.exists(path1)) {
//                        Files.delete(path1);
//                    }
//                }
//
//                // บันทึกไฟล์ใหม่
//                Files.write(path1, file.getBytes());
//
//                // อัพเดตข้อมูลในฐานข้อมูล
//                pdfToUpdate.setDetail(detail);
//                pdfToUpdate.setImg(existingFileName);
//                courseService.updatePDF(pdfToUpdate);
//            } else {
//                // ไม่มีการอัพโหลดไฟล์ใหม่ แต่อาจมีการอัพเดตข้อมูลอื่น ๆ ที่ต้องการทำในกรณีนี้
//                pdfToUpdate.setDetail(detail);
//                courseService.updatePDF(pdfToUpdate);
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return "redirect:/course/add_img"; // หรือไปยังหน้าที่คุณต้องการ
//    }


    @GetMapping("/show_test")
    public String showTest(Model model) {

        return "test"; // ชื่อหน้าแก้ไขของคุณ
    }

    @Autowired
    private TestService testService;
    @PostMapping("/add_Test_ListImg")
    public String addImg(@RequestParam("imageFile") MultipartFile[] imageFiles) throws IOException {
        int latestId = testService.max_id(); // Get the latest id from the database

        int count = 1;
        List<String> newFileNames = new ArrayList<>(); // To store the new file names

        for (MultipartFile imageFile : imageFiles) {
            if (!imageFile.isEmpty()) {
                String uploadDirectory = ImgPath.pathImg + "/addImg/" + (latestId + 1);

                Path directoryPath = Paths.get(uploadDirectory);
                Files.createDirectories(directoryPath);

                String fileName = imageFile.getOriginalFilename();
                String fileExtension = getFileExtension(fileName);

                String formattedId = String.format("%02d", latestId + 1);
                String formattedSequence = String.format("%04d", count);
                String newFileName = String.format("IMG_%s_%s%s", formattedId, formattedSequence, fileExtension);
                Path filePath = Paths.get(uploadDirectory, newFileName);

                // Write the image file to the specified path
                Files.write(filePath, imageFile.getBytes());

                // Store the new file name in the list
                newFileNames.add(newFileName);

                count++;
            }
        }

        // Create an ImageModel instance and add the file names to the image list
        Test_img image = new Test_img();
        image.getImgNames().addAll(newFileNames);

        // Save the image data to the database
        image.setId(latestId+1);
        testService.doAddImg(image);

        return "redirect:/"; // Redirect to the desired page
    }

    // Helper function to get the file extension

}
