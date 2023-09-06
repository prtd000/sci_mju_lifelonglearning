package lifelong.controller;

import lifelong.model.*;
import lifelong.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private RegisterService registerService;

    @Autowired
    private RequestOpCourseService requestOpCourseService;

    @Autowired
    private PaymentService paymentService;

    @GetMapping("/login")
    public String loginPage(Model model) {
        model.addAttribute("title", "Login");
        return "member/login";
    }

    @GetMapping("/{memid}/register_course/{courseid}/{requestid}")
    public String viewRegisterCourse(@PathVariable("memid") String mem_id, @PathVariable("courseid") String courseid, @PathVariable("requestid") long requestid, Model model) {
        Course course = courseService.getCourseDetail(courseid);
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(requestid);
        model.addAttribute("request_op_course", requestOpenCourse);
        model.addAttribute("course_detail", course);
        model.addAttribute("course_id", courseid);
        model.addAttribute("member_id", mem_id);
        model.addAttribute("title", "RegisterCourse");
        model.addAttribute("register", new Register());
        return "member/register_course";
    }

    @GetMapping("/{memid}/register_course/{courseid}/{requestid}/register")
    public String registerCourse(@PathVariable("courseid") String courseid, @PathVariable("requestid") long requestid, @PathVariable("memid") String memid) {
        /*****Insert Register*****/
        Register register = new Register();
        register.setRegister_date(new Date());
        register.setStudy_result(false);
        register.setRequestOpenCourse(requestOpCourseService.getRequestOpenCourseDetail(requestid));
        register.setMember(memberService.getMemberById(memid));
        registerService.saveRegister(register);

        /*****GetLastLow for Insert To Invoice Table After RegisterCourse ********/
        long register_id = registerService.getLastRow().getRegister_id();
        Date register_date = registerService.getLastRow().getRegister_date();
        boolean study_result = registerService.getLastRow().getStudy_result();
        Member member = registerService.getLastRow().getMember();
        RequestOpenCourse requestOpenCourse = registerService.getLastRow().getRequestOpenCourse();
        Register register1 = new Register(register_id, register_date, study_result, member, requestOpenCourse);

        /*****Insert Invoice*****/
        Invoice invoice = new Invoice();
        invoice.setPay_status(false);
        Date payStart = requestOpCourseService.getRequestOpenCourseDetail(requestid).getApplicationResult();
        Date payEnd = requestOpCourseService.getRequestOpenCourseDetail(requestid).getStartStudyDate();

        // แปลงเป็น Calendar
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(payEnd);

        // ลบ 1 วัน
        calendar.add(Calendar.DAY_OF_MONTH, -1);

        // อัปเดตค่าใน payEnd
        payEnd = calendar.getTime();

        invoice.setStartPayment(payStart);
        invoice.setEndPayment(payEnd);
        invoice.setRegister(register1);
        invoice.setApprove_status("รอดำเนินการ");
        registerService.doInvoice(invoice);
        return "redirect:/search_course";
//        return "redirect:/member/"+ memid+"/listcourse";
    }


    @GetMapping("{memid}/listcourse")
    public String listCourseByMember(@PathVariable("memid") String memId, Model model) {
        model.addAttribute("list_course", memberService.getMyListCourse(memId));
        model.addAttribute("list_invoice", memberService.getListInvoice());
        model.addAttribute("mem_username", memberService.getMemberById(memId));
        model.addAttribute("register", registerService.getRegister(memId));
        return "/member/list_course";
    }

    @GetMapping("{memid}/{id}/delete")
    public String deleteRegister(@PathVariable("memid") String memId, @PathVariable("id") long id) {
        registerService.deleteInvoice(id);
        registerService.deleteRegister(id);
        return "redirect:/member/" + memId + "/listcourse";
    }

    /***** Start ViewCourseActivityNews *****/









    /***** End ViewCourseActivityNews *****/

    @GetMapping("{memid}/certificate")
    public String viewCertificate(@PathVariable("memid") String memId, Model model) {
        model.addAttribute("member", memberService.getMemberById(memId));
        return "/member/view_certificate";
    }

    @GetMapping("{memid}/edit_profile")
    public String editProfile(@PathVariable("memid") String memId, Model model) {
        model.addAttribute("member", memberService.getMemberById(memId));
        return "/member/edit_profile";
    }

    @PostMapping(path = "/{memid}/update")
    public String updateProfile(@PathVariable("memid") String memId, @RequestParam Map<String, String> params) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Member member = memberService.getMemberById(memId);
        if (member != null) {
            member.setFirstName(params.get("firstName"));
            member.setLastName(params.get("lastName"));
            member.setBirthday(dateFormat.parse(params.get("birthday")));
            member.setTel(params.get("tel"));
            member.setEmail(params.get("email"));
            member.setEducation(params.get("education"));

            memberService.doRegisterMember(member);
        }
        return "redirect:/member/" + memId + "/edit_profile";
    }

    @GetMapping("{memid}/change_password")
    public String changePassword(@PathVariable("memid") String memId, Model model) {
        model.addAttribute("member", memberService.getMemberById(memId));
        return "/member/change_password";
    }

    @PostMapping(path = "/{memid}/update_password")
    public String updatePassword(@PathVariable("memid") String memId, @RequestParam Map<String, String> params) {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        Member member = memberService.getMemberById(memId);
        if (member != null) {
            member.setPassword(bCryptPasswordEncoder.encode(params.get("confirmPassword")));
            memberService.doRegisterMember(member);
        }
        return "redirect:/member/" + memId + "/edit_profile";
    }


}
