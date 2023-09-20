package lifelong.controller;

import lifelong.model.Course;
import lifelong.model.Member;
import lifelong.model.RequestOpenCourse;
import lifelong.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
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

        // ตรวจสอบและอัพเดต requestStatus สำหรับทุก RequestOpenCourse
        for (RequestOpenCourse requestOpenCourse : requestOpenCourses) {
            requestOpenCourse.checkEndDate();
            requestOpCourseService.updateRequestOpenCourse(requestOpenCourse);
            System.out.println("RequestStatus : " + requestOpenCourse.getRequestStatus());
        }
        for (Course course : courses) {
            System.out.println("CourseStatus : " + course.getStatus());
        }
        model.addAttribute("list_req",requestOpCourseService.getRequestOpenCourses());
        model.addAttribute("courses", courseService.getCourses());
        return "home";
    }

    @GetMapping("/search_course")
    public String searchCourse(Model model) {
        /****Send listRequest****/
        model.addAttribute("listRequest",courseService.getListRequestOpCourse());
        model.addAttribute("listRegister", registerService.getListRegister());
        model.addAttribute("list_invoice",memberService.getListInvoice());
        model.addAttribute("courses", courseService.getCourses());
        model.addAttribute("majors",majorService.getMajors());
        model.addAttribute("list_req",requestOpCourseService.getRequestOpenCourses());

        return "search_course";
    }
    @GetMapping("/{id}")
    public String viewCourseDetail(@PathVariable("id") String id, Model model) {
        Course course = courseService.getCourseDetail(id);
        model.addAttribute("course_detail", course);
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
        model.addAttribute("title", "สำหรับผู้รับผิดชอบหลักสูตร");
        return "lecturer/loginLecturer";
    }
    @GetMapping("/loginAdmin")
    public String loginAdmin(Model model) {
        model.addAttribute("title", "สำหรับผู้ดูแลระบบ");
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
    public String saveMember(@RequestParam Map<String, String> addParams) throws ParseException {

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

        return "redirect:/";
    }

    private Date convertLocalDateToDate(LocalDate localDate) {
        Calendar calendar = new GregorianCalendar();
        calendar.set(localDate.getYear(), localDate.getMonthValue() - 1, localDate.getDayOfMonth());
        return calendar.getTime();
    }


}
