package lifelong.controller;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.Major;
import lifelong.model.RequestOpenCourse;
import lifelong.service.ActivityService;
import lifelong.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/activity")
public class ActivityController {
    @Autowired
    private ActivityService activityService;
    private String title = "ข่าวสาร";

    @GetMapping("/public/list_activity")
    public String listCourse(Model model) {
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
    public String showFormAddCourse(Model model) {
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
        return "redirect:/";
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

    @GetMapping("/{id}/delete")
    public String deleteProduct(@PathVariable("id") long id) {
        activityService.deleteActivity(id);
        return "redirect:/activity/public/list_activity";
    }
}
