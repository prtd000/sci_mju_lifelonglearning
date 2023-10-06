package lifelong.controller;

import lifelong.model.*;
import lifelong.service.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.persistence.criteria.CriteriaBuilder;
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

    @Autowired
    private ActivityService activityService;

    @Autowired
    private SessionFactory sessionFactory;


    @GetMapping("/login")
    public String loginPage(Model model) {
        model.addAttribute("title", "Login");
        return "member/login";
    }

    @GetMapping("/{memid}/register_course/{courseid}/{requestid}")
    public String viewRegisterCourse(@PathVariable("memid") String mem_id, @PathVariable("courseid") String courseid, @PathVariable("requestid") long request_id, Model model) {
        boolean registered = false;

        Course course = courseService.getCourseDetail(courseid);
        model.addAttribute("course", course);
        model.addAttribute("activity", activityService.getViewCourseActivityNews(request_id));
        model.addAttribute("amount" , registerService.getAmountRegisteredByCourseId(courseid).size());
        System.out.println("Size Amount : " + registerService.getAmountRegisteredByCourseId(courseid).size());

        try{
            model.addAttribute("req", requestOpCourseService.getRequestOpCourseByCourseId(courseid));
            model.addAttribute("registerMember" ,registerService.checkMemberRegisteredPass(mem_id,request_id));

        }catch (Exception e){

        }

        for (Register r : registerService.getRegister(mem_id)) {
            if (r.getRequestOpenCourse().getRequest_id() == request_id) {
                registered = true;
            }
        }
        model.addAttribute("registered", registered);

        return "member/register_course";
    }

    @Transactional
    @GetMapping("/{memid}/register_course/{courseid}/{requestid}/register")
    public String registerCourse(@PathVariable("courseid") String courseid, @PathVariable("requestid") long requestid, @PathVariable("memid") String memid) {

        Session session = sessionFactory.getCurrentSession();

        /*****Insert Register*****/
        Register register = new Register();
        register.setRegister_date(new Date());
        register.setStudy_result("ยังไม่ได้ชำระเงิน");
        register.setRequestOpenCourse(requestOpCourseService.getRequestOpenCourseDetail(requestid));
        register.setMember(memberService.getMemberById(memid));
        registerService.saveRegister(register);

        /*****GetLastLow for Insert To Invoice Table After RegisterCourse ********/
        long register_id = registerService.getLastRow().getRegister_id();
        Date register_date = registerService.getLastRow().getRegister_date();
        String study_result = registerService.getLastRow().getStudy_result();
        Member member = registerService.getLastRow().getMember();
        RequestOpenCourse requestOpenCourse = registerService.getLastRow().getRequestOpenCourse();
        Register register1 = new Register(register_id, register_date, study_result, member, requestOpenCourse);

        /*****Insert Invoice*****/
        Invoice invoice = new Invoice();
        invoice.setPay_status(false);
        Date payStart = requestOpCourseService.getRequestOpenCourseDetail(requestid).getStartPayment();
        Date payEnd = requestOpCourseService.getRequestOpenCourseDetail(requestid).getEndPayment();

        // ลบ 1 วัน
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(payEnd);
//        calendar.add(Calendar.DAY_OF_MONTH, -1);
//        payEnd = calendar.getTime();

        invoice.setStartPayment(payStart);
        invoice.setEndPayment(payEnd);
        invoice.setRegister(register1);
        invoice.setApprove_status("รอดำเนินการ");
        Invoice invoice1 = (Invoice) session.merge(invoice);

        registerService.doInvoice(invoice1);
        return "redirect:/member/" + memid + "/listcourse";
    }

    @GetMapping("{memid}/listcourse")
    public String listCourseByMember(@PathVariable("memid") String memId, Model model) {
        Date currentDate = new Date(); // วันปัจจุบัน

        model.addAttribute("list_course", memberService.getMyListCourse(memId));
        model.addAttribute("list_invoice", memberService.getListInvoice());
        model.addAttribute("mem_username", memberService.getMemberById(memId));
        model.addAttribute("register", registerService.getRegister(memId));
        model.addAttribute("receipt" , paymentService.getReceiptByMemberId(memId));


        Calendar calendar = Calendar.getInstance();


        List<Invoice> invoices = paymentService.getListInvoiceByMemberId(memId);
        for (Invoice list : invoices) {
            calendar.setTime(list.getEndPayment());
            calendar.add(Calendar.DAY_OF_MONTH, + 1);

            if (!list.getPay_status() && currentDate.after(calendar.getTime())) {
                list.setApprove_status("เลยกำหนดชำระเงิน");
                registerService.doInvoice(list);
            }
        }
        return "/member/list_course";
    }

    @GetMapping("{memid}/{regis_id}/delete")
    public String deleteRegister(@PathVariable("memid") String memId, @PathVariable("regis_id") long id) {
        Register register = registerService.getRegisterByRegisterId(id);
        registerService.deleteInvoice(id);
        registerService.deleteRegister(id);

        return "redirect:/member/" + memId + "/register_course/" + register.getRequestOpenCourse().getCourse().getCourse_id() + "/" + register.getRequestOpenCourse().getRequest_id();
    }

    @GetMapping("{memid}/certificate/{registerId}")
    public String viewCertificate(@PathVariable("memid") String memId, @PathVariable("registerId") long regisId, Model model) {
        model.addAttribute("register", registerService.getRegisterByRegisterId(regisId));
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

    @GetMapping("private_activity/{ac_id}")
    public String activityDetail(@PathVariable("ac_id") String acId, Model model) {
        model.addAttribute("ac_detail" , activityService.getActivityDetail(acId));
        return "/member/activity_private";
    }


}
