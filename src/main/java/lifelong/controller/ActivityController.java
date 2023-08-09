package lifelong.controller;

import lifelong.model.*;
import lifelong.service.ActivityService;
import lifelong.service.CourseService;
import lifelong.service.LecturerService;
import lifelong.service.RequestOpCourseService;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/activity")
public class ActivityController {
    @Autowired
    private ActivityService activityService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private RequestOpCourseService requestOpCourseService;
    @Autowired
    private LecturerService lecturerService;
    @Autowired
    private SessionFactory sessionFactory;
    private String title = "ข่าวสาร";

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

    @GetMapping("/public/{id}/edit_course_activity_page")
    public String showEditCourseActivity(@PathVariable("id") long id, Model model) {
        Activity activity = activityService.getActivityDetail(id);
        model.addAttribute("title", "แก้ไข" + title + "ทั่วไป");
        model.addAttribute("activities", activity);
        return "lecturer/edit_Course_Activity";
    }

    @GetMapping("/public/add_activity")
    public String showFormAddActivity(Model model) {
        model.addAttribute("title", "เพิ่ม" + title);
//        model.addAttribute("add_public_activity", new Activity());
        return "admin/add_Public_Activity";
    }

    @PostMapping(path="/admin/save_public_add_activity")
    public String saveAddPublicActivity(@RequestParam Map<String, String> allReqParams) throws ParseException {
        String ac_name = allReqParams.get("ac_name");
        Date ac_date =  new Date();
        String ac_detail = allReqParams.get("ac_detail");
        String ac_type = "Public";
        String ac_img = allReqParams.get("ac_img");

        Activity public_activity_add = new Activity(ac_name,ac_date,ac_detail,ac_type,ac_img);
        activityService.addActivityNews(public_activity_add);
        return "redirect:/course/list_all_course";
    }
    @PostMapping (path="/{id}/update_public_add_activity")
    public String updateActivity(@PathVariable("id") String ac_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
        long existingActivityId = Long.parseLong(ac_id);
        Activity existingActivity = activityService.getActivityDetail(existingActivityId);
        System.out.println("PASS");
        if (existingActivity != null) {
            existingActivity.setName(allReqParams.get("ac_name"));
            existingActivity.setDetail(allReqParams.get("ac_detail"));
            existingActivity.setImg(allReqParams.get("ac_img"));
            activityService.updateActivity(existingActivity);
        }
        return "redirect:/activity/public/list_activity";
    }
    @PostMapping (path="/{id}/update_course_add_activity")
    public String updateCourseActivity(@PathVariable("id") long ac_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
//        long existingActivityId = Long.parseLong(ac_id);
        Activity existingActivity = activityService.getActivityDetail(ac_id);
        System.out.println("PASS");
        if (existingActivity != null) {
            existingActivity.setName(allReqParams.get("ac_name"));
            existingActivity.setDetail(allReqParams.get("ac_detail"));
            existingActivity.setImg(allReqParams.get("ac_img"));
            activityService.updateActivity(existingActivity);
        }
        return "redirect:/activity/"+ac_id+"/view_course_activity_page";
    }

    @GetMapping("/{id}/delete")
    public String deleteActivity(@PathVariable("id") long id) {
        Activity activity = activityService.getActivityDetail(id);
        if(activity.getType().equals("Public")){
            activityService.deleteActivity(id);
            return "redirect:/course/list_all_course";
        }else {
            activityService.deleteActivity(id);
            return "redirect:/request_open_course/view_approve_request_open_course/"+activity.getRequestOpenCourse().getRequest_id();
        }
    }
    @GetMapping("/{roc_id}/list_course_activity")
    public String listCourseActivity(Model model, @PathVariable("roc_id") long roc_id) {
        model.addAttribute("title", "รายการ" + title);
        model.addAttribute("list_activities", activityService.getPublicActivity());
        return "admin/list_Public_Activity";
    }
    @GetMapping("/{roc_id}/add_course_activity")
    public String showFormAddCourseActivity(Model model, @PathVariable("roc_id") long roc_id) {
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        model.addAttribute("title", "เพิ่มข่าวสารประจำหลักสูตร");
        model.addAttribute("ROC_detail", requestOpenCourse);
//        model.addAttribute("add_public_activity", new Activity());
        return "lecturer/add_Course_Activity";
    }
    @Transactional
    @PostMapping (path="/{id}/save_add_course_activity")
    public String saveAddRequestCourseActivity(@PathVariable("id") long roc_id,@RequestParam Map<String, String> allReqParams) throws ParseException {
        Date ac_date =  new Date();
        String ac_name = allReqParams.get("ac_name");
        String ac_detail = allReqParams.get("ac_detail");
        String ac_img = allReqParams.get("ac_img");
        String ac_type = "Private";
        RequestOpenCourse requestOpenCourse = requestOpCourseService.getRequestOpenCourseDetail(roc_id);
        Lecturer lecturer = lecturerService.getLecturerById("somjai");

        Activity public_activity_add = new Activity(ac_name,ac_date,ac_detail,ac_type,ac_img,requestOpenCourse,lecturer);

        Session session = sessionFactory.getCurrentSession();

        // ใช้ session.merge() เพื่อรวมหรืออัปเดตอ็อบเจกต์ลงใน session
        Activity mergedActivity = (Activity) session.merge(public_activity_add);

        // เพิ่มกิจกรรมเข้าสู่ระบบโดยใช้อ็อบเจกต์ที่รวมแล้ว
        activityService.addActivityNews(mergedActivity);
        return "redirect:/request_open_course/view_approve_request_open_course/"+roc_id;
    }

    @GetMapping("/{id}/view_course_activity_page")
    public String showCourseActivityDetail(@PathVariable("id") long id, Model model) {
        Activity activity = activityService.getActivityDetail(id);
        model.addAttribute("title", "รายละเอียด" + title + "ทั่วไป");
        model.addAttribute("activities", activity);
        return "lecturer/view_detail_course_activity";
    }
}
