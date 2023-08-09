package lifelong.dao;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface ActivityDao {
    void addActivityNews(Activity activity);

    List<Activity> getPublicActivity();

    Activity getActivityDetail(long id);
    List<Activity> getActivityByRequestOpenCourseId(long roc_id);
    Activity updateActivity (Activity activity) ;

    void deleteActivity(long id);
}
