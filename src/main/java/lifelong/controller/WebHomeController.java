package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Member;
import lifelong.model.Register;
import lifelong.model.RequestOpenCourse;
import lifelong.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class WebHomeController {
    @Autowired
    private CourseService courseService;

    @Autowired
    private RequestOpCourseService requestOpCourseService;

    @Autowired
    private MajorService majorService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private RegisterService registerService;

    @GetMapping("/")
    public String listCourse(Model model) {
        List<RequestOpenCourse> requestOpenCourses = requestOpCourseService.getRequestOpenCourses();
        List<Course> courses = courseService.getCourses();
        List<Register> registers = registerService.getListRegister();
        Date currentDate = new Date(); // วันปัจจุบัน
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(currentDate);
        calendar.add(Calendar.WEEK_OF_YEAR, -1); // ลบ 1 สัปดาห์

        Date oneWeekAgo = calendar.getTime();

        // ตรวจสอบและอัพเดต requestStatus สำหรับทุก RequestOpenCourse
        for (RequestOpenCourse requestOpenCourse : requestOpenCourses) {
            requestOpenCourse.checkEndDate();
            System.out.println("RequestStatus : " + requestOpenCourse.getRequestStatus());

            if (Objects.equals(requestOpenCourse.getRequestStatus(), "ผ่าน")){
                if (currentDate.getTime() > requestOpenCourse.getEndRegister().getTime() && requestOpenCourse.getRegisterList().size() == 0){
                    requestOpenCourse.getCourse().setStatus("ยังไม่เปิดสอน");
                    requestOpenCourse.setRequestStatus("ถูกยกเลิก");
                }
                if (requestOpenCourse.getCourse().getFee() == 0){
                    if (currentDate.getTime() > requestOpenCourse.getEndRegister().getTime() && currentDate.getTime() < requestOpenCourse.getApplicationResult().getTime()){
                        requestOpenCourse.getCourse().setStatus("ชำระเงิน");
                    }else if (currentDate.getTime() >= requestOpenCourse.getApplicationResult().getTime()){
                        requestOpenCourse.getCourse().setStatus("เปิดสอน");
                    } else if (currentDate.getTime() > requestOpenCourse.getEndStudyDate().getTime()) {
                        requestOpenCourse.getCourse().setStatus("ยังไม่เปิดสอน");
                        requestOpenCourse.setRequestStatus("เสร็จสิ้น");
                    }
                }else if (currentDate.getTime() > requestOpenCourse.getEndRegister().getTime() && currentDate.getTime() <= requestOpenCourse.getEndPayment().getTime()) {
                    requestOpenCourse.getCourse().setStatus("ชำระเงิน");
                }else if (currentDate.getTime() >= requestOpenCourse.getApplicationResult().getTime()){
                    requestOpenCourse.getCourse().setStatus("เปิดสอน");
                }else if (currentDate.getTime() > requestOpenCourse.getEndStudyDate().getTime()) {
                    requestOpenCourse.getCourse().setStatus("ยังไม่เปิดสอน");
                    requestOpenCourse.setRequestStatus("เสร็จสิ้น");
                }
            }

            // เพิ่มเงื่อนไขในการลบแถว
            if (Objects.equals(requestOpenCourse.getRequestStatus(), "ไม่ผ่าน") && requestOpenCourse.getRequestDate().before(oneWeekAgo)) {
                // ลบอ็อบเจกต์ RequestOpenCourse จากฐานข้อมูล
                requestOpCourseService.checkDeleteRequestOpenCourse(requestOpenCourse.getRequest_id());
                System.out.println("ลบสำเร็จ"+requestOpenCourse.getRequest_id());
            }
//            if (requestOpenCourse.getEndRegister().toInstant().isBefore(currentDate.toInstant()) && requestOpenCourse.getQuantity() == 0) {
//                requestOpenCourse.setRequestStatus("ถูกยกเลิก");
//            }
            requestOpCourseService.updateRequestOpenCourse(requestOpenCourse);

        }
        model.addAttribute("list_req",requestOpenCourses);
        model.addAttribute("courses", courses);


        return "home";
    }

    @GetMapping("/search_course")
    public String searchCourse(Model model) {
        /****Send listRequest****/
        model.addAttribute("listRequest",courseService.getAllListRequestCourse());
        model.addAttribute("listRegister", registerService.getListRegister());
        model.addAttribute("list_invoice",memberService.getListInvoice());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("majors",majorService.getMajors());
        model.addAttribute("list_req",requestOpCourseService.getRequestOpenCourses());

        return "search_course";
    }
    @GetMapping("/{id}")
    public String viewCourseDetail(@PathVariable("id") String id, Model model) {
        Course course = courseService.getCourseById(id);
        model.addAttribute("course_detail", course);
        model.addAttribute("amount" , registerService.getAmountRegisteredByCourseId(id).size());

        try{
            RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpCourseByCourseId(id);
            model.addAttribute("req", requestOpenCourse);

        }catch (Exception e){

        }
        return "course/course-detail";
    }
//
//    @GetMapping("/search_course/{value}")
//    public String searchCourseByCourseName(Model model, @PathVariable("value") String courseName) {
//        System.out.println(courseName);
//        model.addAttribute("majorName",courseName);
//        model.addAttribute("courses", courseService.getCoursesByName(courseName));
//        model.addAttribute("majors",majorService.getMajors());
//        return "search_course";
//    }

    @GetMapping("/view_activity")
    public String viewActivityNews(Model model) {
        model.addAttribute("list_activities", activityService.getPublicActivity());
        return "view_public_activity";
    }

    /***********Login**********/

    @GetMapping("/loginMember")
    public String loginMember(Model model) {
        model.addAttribute("title", "ลงชื่อเข้าสู่ระบบ");
        return "member/loginMember";
    }
    @GetMapping("/loginLecturer")
    public String loginLecturer(Model model) {
        model.addAttribute("title", "ผู้รับผิดชอบหลักสูตร");
        return "lecturer/loginLecturer";
    }
    @GetMapping("/loginAdmin")
    public String loginAdmin(Model model) {
        model.addAttribute("title", "ผู้ดูแลระบบ");
        return "admin/loginAdmin";
    }
    @GetMapping("/access-denied")
    public String showAccessDenied(Model model) {
        model.addAttribute("title", "Access Denied");
        return "access-denied";
    }
    /***********Register Member**********/

    @GetMapping("/register_member")
    public String register(Model model, HttpSession session) {
        //model.addAttribute("listUser",userService.getUsernames());
        session.setAttribute("listUser" , userService.getUsernames());
        return "register-member";
    }

    @PostMapping("/register_member/save")
    public String saveMember(@RequestParam Map<String, String> addParams, HttpSession session) throws ParseException {

        /******Change*******/
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String hbd = addParams.get("birthday");
        LocalDate birthday = LocalDate.parse(hbd, dateFormatter);
//        LocalDate newBirthday = birthday.plusYears(543);

        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

        String idcard = addParams.get("idcard");
        String firstName = addParams.get("firstName");
        String lastName = addParams.get("lastName");
        Date new_birthday = convertLocalDateToDate(birthday);
        String gender = addParams.get("gender");
        String tel = addParams.get("tel");
        String email = addParams.get("email");
        String education = addParams.get("education");
        String username = addParams.get("username");
        String password = addParams.get("confirmPassword");

        String encrypted = bCryptPasswordEncoder.encode(password);
        System.out.println("Encrypt: " + encrypted);

        Member member = new Member(username,encrypted,idcard,firstName,lastName,gender,new_birthday,email,tel,education);
        memberService.doRegisterMember(member);

        session.setAttribute("member", member);

        return "redirect:/";
    }

    private Date convertLocalDateToDate(LocalDate localDate) {
        Calendar calendar = new GregorianCalendar();
        calendar.set(localDate.getYear(), localDate.getMonthValue() - 1, localDate.getDayOfMonth());
        return calendar.getTime();
    }


}
