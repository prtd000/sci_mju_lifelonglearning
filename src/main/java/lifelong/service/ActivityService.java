package lifelong.service;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface ActivityService {
    void addActivityNews(Activity activity);

    List<Activity> getPublicActivity();

    List<Activity> getViewCourseActivityNews(long req_id);

    Activity getActivityDetail(String activityId);
    Activity getActivityDetailToUpdate(String id , String lec_id);

    List<Activity> getActivityDetailByCourseId(long roc_Id);

    void updateActivity(Activity activity);
    void deleteActivity(String acId);

    void deleteCourseActivity(String id , String lec_id);

    int getLatestActivityCount();
    int getActivityMaxId(String activity_type);
}
