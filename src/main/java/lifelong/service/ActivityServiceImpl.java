package lifelong.service;

import lifelong.dao.ActivityDao;
import lifelong.model.Activity;
import lifelong.model.Course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

@Service
public class ActivityServiceImpl implements ActivityService{
    @Autowired
    private ActivityDao activityDao;

    @Override
    @Transactional
    public void addActivityNews(Activity activity) {
        String activity_type = activity.getType();
        long id = activityDao.getActivityMaxId(activity_type);
        activity.setAc_id(generateMaxActivityId(id + 1,activity_type));
        activityDao.addActivityNews(activity);
    }

    @Override
    @Transactional
    public List<Activity> getPublicActivity() {
        return activityDao.getPublicActivity();
    }

    @Override
    @Transactional
    public Activity getActivityDetail(String activityId) {
        return activityDao.getActivityDetail(activityId);
    }
    @Override
    @Transactional
    public Activity getActivityDetailToUpdate(String id , String lec_id) {
        return activityDao.getActivityDetailToUpdate(id,lec_id);
    }

    @Override
    @Transactional
    public List<Activity> getActivityDetailByCourseId(long roc_Id) {
        return activityDao.getActivityByRequestOpenCourseId(roc_Id);
    }
    @Override
    @Transactional
    public int getLatestActivityCount() {
        return activityDao.getLatestActivityCount();
    }

    @Override
    @Transactional
    public int getActivityMaxId(String activity_type) {
        return activityDao.getActivityMaxId(activity_type);
    }

    @Override
    @Transactional
    public void updateActivity(Activity activity) {
        activityDao.updateActivity(activity);
    }

    @Override
    @Transactional
    public void deleteActivity(String acId) {
        activityDao.deleteActivity(acId);
    }

    @Override
    @Transactional
    public void deleteCourseActivity(String id , String lec_id){
        activityDao.deleteCourseActivity(id,lec_id);
    }

    public String generateMaxActivityId (long id,String activity_type) {
        String result = String.valueOf(id);
        while (result.length() != 3) {
            result = "0" + result;
        }
        if (Objects.equals(activity_type, "Public")){
            return "AP" + result;
        }else {
            return "AC" + result;
        }
    }
}
