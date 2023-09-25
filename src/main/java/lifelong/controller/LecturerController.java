package lifelong.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
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
import org.springframework.web.multipart.MultipartFile;
import utils.ImgPath;

import java.io.File;
import java.io.IOException;
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
    @GetMapping("/{lecturer_id}/add_roc")
    public String getCourseRequest(@PathVariable("lecturer_id") String lecturer_id,Model model) {
        model.addAttribute("title", "ร้องขอเปิด" + title);
        model.addAttribute("lecturer",requestOpCourseService.getLecturerDetail(lecturer_id));
        model.addAttribute("courses", courseService.getCoursesByCourseStatus());
        model.addAttribute("request_open_course", new RequestOpenCourse());
        return "lecturer/add_request_open_course";
    }
    @PostMapping (path="/{id}/save")
    public String doRequestOpenCourseDetail(@PathVariable("id") String lec_id,
                                            @RequestParam Map<String, String> allReqParams,
                                            @RequestParam("signature") MultipartFile signature) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // เปลี่ยนรูปแบบวันที่ให้ตรงกับ HTML
        int round = 0;
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
        String link_mooc = allReqParams.get("link_mooc");
        String requestStatusBool = "รอดำเนินการ";
//        String signature = allReqParams.get("signature");
        Course course = courseService.getCourseById(allReqParams.get("course_id"));
//        String lecturer_username = allReqParams.get("lecturer_username");
        Lecturer lecturer = lecturerService.getLecturerById(lec_id);

        try {

            // เพิ่ม รูปภาพ
            // กำหนด path ที่จะบันทึกไฟล์
            String uploadPathIMG = ImgPath.pathImg + "/request_open_course/signature/";

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
            int maxIdImgFile = requestOpCourseService.getSignatureCourseMaxId(); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด

            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
            Path directoryPath = Paths.get(uploadPathIMG);
            Files.createDirectories(directoryPath);

            String imgOriginalFileName = signature.getOriginalFilename();
            String imgFileExtension = getFileExtension(imgOriginalFileName);
            String signature_img = "";
            // สร้างรหัสไฟล์ใหม่ในรูปแบบ "SIG0001", ...
            signature_img = String.format("SIG%04d%s", ++maxIdImgFile, imgFileExtension);
            Path imgFilePath = Paths.get(uploadPathIMG, signature_img);
            Files.write(imgFilePath, signature.getBytes());

            // บันทึก path ไปยังฐานข้อมูล
            RequestOpenCourse requestOpenCourse_toAdd;
            if (Objects.equals(type_learn, "เรียนในสถานศึกษา")){
                requestOpenCourse_toAdd = new RequestOpenCourse(round,requestDate, startRegisterDate, endRegisterDate, quantity, startStudyDate, endStudyDate, studyTime, type_learn, type_teach, applicationResultDate, requestStatusBool, signature_img, course, lecturer);
                requestOpenCourse_toAdd.setLocation(location);
            } else if (Objects.equals(type_learn, "เรียนออนไลน์")) {
                requestOpenCourse_toAdd = new RequestOpenCourse(round,requestDate, startRegisterDate, endRegisterDate, quantity, startStudyDate, endStudyDate, studyTime, type_learn, type_teach, applicationResultDate, requestStatusBool, signature_img, course, lecturer);
                requestOpenCourse_toAdd.setLinkMooc(link_mooc);
            }else {
                requestOpenCourse_toAdd = new RequestOpenCourse(round,requestDate, startRegisterDate, endRegisterDate, quantity, startStudyDate, endStudyDate, studyTime, type_learn, type_teach, applicationResultDate, requestStatusBool, signature_img, course, lecturer);
                requestOpenCourse_toAdd.setLocation(location);
                requestOpenCourse_toAdd.setLinkMooc(link_mooc);
            }
            requestOpCourseService.saveRequestOpenCourse(requestOpenCourse_toAdd);
        } catch (IOException e) {
            e.printStackTrace();
        }
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
    //**********************************************************************//

    //*********************Edit Request Course****************************//
    @GetMapping("/{lec_id}/{roc_id}/update_page")
    public String getRequestCourseDetail(@PathVariable("lec_id") String lec_id,@PathVariable("roc_id") long roc_id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetailToUpdate(roc_id,lec_id);
        model.addAttribute("title", "แก้ไขคำร้องขอเปิด" + title);
        model.addAttribute("lecturer", requestOpCourseService.getLecturer());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("request_open_course", requestOpenCourse);
        return "lecturer/update_request_open_course";
    }
    @PostMapping (path="/{lec_id}/{req_id}/update")
    public String doEditRequestCourseDetail(@PathVariable("lec_id") String lec_id,
                                            @PathVariable("req_id") String req_id,
                                            @RequestParam(value = "original_signature", required = false) String original_signature,
                                            @RequestParam("signature") MultipartFile signature,
                                            @RequestParam Map<String, String> allReqParams) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // เปลี่ยนรูปแบบวันที่ให้ตรงกับ HTML
        // ดึงข้อมูล PDF ที่ต้องการแก้ไขจากฐานข้อมูล
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
            existingRequest.setType_teach(allReqParams.get("type_teach"));

            existingRequest.setCourse(courseService.getCourseById(allReqParams.get("course_id")));
        }

        try {
//            AddImg pdfToUpdate = courseService.getPdfById(pdfId);
            // กำหนด path ที่จะบันทึกไฟล์
            String uploadPathSIG = ImgPath.pathImg + "/request_open_course/signature/";
//            String uploadPath = ImgPath.pathImg + "/course_pdf/pdf/";
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
        } catch (IOException e) {
            e.printStackTrace();
        }
//        String lec_id = existingRequest.getLecturer().getUsername();
        return "redirect:/lecturer/"+ lec_id +"/list_request_open_course";
    }
    //******************************************************************************//

    //***************************Cancel Course Detail***********************************//
    @GetMapping("/{lec_id}/{roc_id}/delete_request_open_course")
    public String doEditCourseActivity(@PathVariable("lec_id")String lec_id,@PathVariable("roc_id") long roc_id) throws IOException {
//        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetailToUpdate(roc_id,lec_id);
//        String lec_id = requestOpenCourse.getLecturer().getUsername();
        List<Register> registers = requestOpCourseService.checkRegisterToDelete(roc_id);
        if (registers.size() == 0){
            RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
            String signature = requestOpenCourse.getSignature();
            // ลบข้อมูลเดิมก่อน
            String deletePath = ImgPath.pathImg + "/request_open_course/signature/";
            Path deletedirectoryPath = Paths.get(deletePath,signature);
            Files.delete(deletedirectoryPath);
            // ลบข้อมูลกิจกรรมที่เกี่ยวข้อง
            List<Activity> activities = activityService.getActivityDetailByCourseId(roc_id);
            for (Activity activity : activities) {
                // ลบข้อมูลที่เกี่ยวข้องกับกิจกรรม (เช่น ไฟล์แนบ)
                String deleteImgActivityPath = ImgPath.pathImg + "/activity/private/"+activity.getAc_id()+"/";
                Path deletedirectoryImgActivityPath = Paths.get(deleteImgActivityPath);
                if (Files.isDirectory(deletedirectoryImgActivityPath)) {
                    // ลบไดเร็กทอรีและเนื้อหาภายใน
                    Files.walk(deletedirectoryImgActivityPath)
                            .sorted(Comparator.reverseOrder())
                            .map(Path::toFile)
                            .forEach(File::delete);
                } else {
                    // ลบไฟล์
                    Files.delete(deletedirectoryImgActivityPath);
                }
                // ลบข้อมูลกิจกรรม
                activityService.deleteActivity(activity.getAc_id());
            }
            requestOpCourseService.deleteRequestOpenCourse(roc_id,lec_id);
            //แก้ไขตาราง Course
            Course course = courseService.getCourseById(requestOpenCourse.getCourse().getCourse_id());
            course.setStatus("ยังไม่เปิดสอน");
            courseService.updateCourse(course);
        }else {
            // ส่งพารามิเตอร์ "error" ใน URL เพื่อระบุว่าเกิดข้อผิดพลาด
            return "redirect:/lecturer/" + lec_id + "/list_request_open_course?error=true";
        }

        return "redirect:/lecturer/"+ lec_id +"/list_request_open_course";
    }
    //**********************************************************************************//

    //*************************List Approved Course ต้องเพิ่ม หรือป่าว***************************//
    @GetMapping("/{lecturer_id}/list_Approved_request_open_course")
    public String getListApprovedCourseDetail(@PathVariable("lecturer_id") String lecturer_id,Model model) {
        model.addAttribute("title", "รายการ");
        model.addAttribute("lecturer_id", lecturer_id);
        model.addAttribute("requests_open_course", requestOpCourseService.getRequestOpenCoursesByLecturerId(lecturer_id));
        return null;
    }
    //**********************************************************************//

    //**********************List Members*********************//
    @GetMapping("/{lecturer_id}/{request_id}/list_member_to_approve")
    public String getListMembers(@PathVariable("lecturer_id") String lecturer_id,@PathVariable("request_id") long request_id , Model model) {
        List<Register> register = registerService.getRegisterByRequestIdAndPayStatus(request_id);
        model.addAttribute("title","TEST");
        model.addAttribute("registers",register);
        model.addAttribute("lecturer_id",lecturer_id);
        return "lecturer/list_member_approve_course";
    }
    //***********************************************************//

    //**************************getPrintListMember() IReport*******************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
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
            register.setStudy_result("ผ่านหลักสูตร");
        } else if ("ไม่ผ่านหลักสูตร".equals(studyResult)) {
            register.setStudy_result("ไม่ผ่านหลักสูตร");
        }
        String lec_id = register.getRequestOpenCourse().getLecturer().getUsername();
        registerService.updateRegister(register);

        return "redirect:/lecturer/" +lec_id+"/"+ request_id + "/list_member_to_approve";
    }
    //******************************************************//

    //**************************View Sample Certificate*******************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//

    //***********************Upload Signature******************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
    //*********************************************************************//
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
                String uploadPath = ImgPath.pathImg + "/activity/private/"+folderName+"/";
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
                String deletePath = ImgPath.pathImg + "/activity/private/"+existingActivity.getAc_id()+"/";
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
                    String uploadPath = ImgPath.pathImg + "/activity/private/"+existingActivity.getAc_id()+"/";
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
        String deletePath = ImgPath.pathImg + "/activity/private/"+activity.getAc_id()+"/";
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

