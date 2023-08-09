package lifelong.controller;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;
import lifelong.service.ActivityService;
import lifelong.service.MajorService;
import lifelong.service.RequestOpCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import lifelong.service.CourseService;

import javax.validation.Valid;
import java.text.ParseException;
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
    @GetMapping("/view_request_open_course/{id}")
    public String showRequestOpenCourse(@PathVariable("id") long id, Model model) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(id);
        model.addAttribute("title", "ดูข้อมูลการร้องขอ");
        model.addAttribute("ROC_detail", requestOpenCourse);
        return "admin/view_request_open_course_by_admin";
    }
    @PostMapping(path="/view_request_open_course/{id}/approve")
    public String approveRequestOpenCourse(@PathVariable("id") long roc_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
        RequestOpenCourse existingRequestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        if (existingRequestOpenCourse != null) {
            existingRequestOpenCourse.setRequestStatus(true);
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

}
