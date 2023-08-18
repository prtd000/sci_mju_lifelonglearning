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




}
