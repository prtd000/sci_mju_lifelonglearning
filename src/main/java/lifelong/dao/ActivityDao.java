package lifelong.dao;

import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;

import java.util.List;

public interface ActivityDao {
    void addActivityNews(Activity activity);

    List<Activity> getPublicActivity();
    List<Activity> getPublicActivityLast3Months();

    List<Activity> getPrivateActivity();

    List<Activity> getViewCourseActivityNews(long req_id);

    Activity getActivityDetail(String id);
    Activity getActivityDetailToUpdate(String id , String lec_id);
    List<Activity> getActivityByRequestOpenCourseId(long roc_id);
    Activity updateActivity (Activity activity) ;

    void deleteActivity(String id);
    void deleteCourseActivity(String id , String lec_id);
    int getActivityMaxId(String activity_type);
    int getLatestActivityCount();
}
