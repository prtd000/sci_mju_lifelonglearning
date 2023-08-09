package lifelong.service;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface ActivityService {
    void addActivityNews(Activity activity);

    List<Activity> getPublicActivity();

    Activity getActivityDetail(long activityId);

    List<Activity> getActivityDetailByCourseId(long roc_Id);

    void updateActivity(Activity activity);
    void deleteActivity(long acId);
}
