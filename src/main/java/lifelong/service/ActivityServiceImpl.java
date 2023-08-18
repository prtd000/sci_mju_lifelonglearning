package lifelong.service;

import lifelong.dao.ActivityDao;
import lifelong.model.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService{
    @Autowired
    private ActivityDao activityDao;

    @Override
    @Transactional
    public void addActivityNews(Activity activity) {
        activityDao.addActivityNews(activity);
    }

    @Override
    @Transactional
    public List<Activity> getPublicActivity() {
        return activityDao.getPublicActivity();
    }

    @Override
    @Transactional
    public Activity getActivityDetail(long activityId) {
        return activityDao.getActivityDetail(activityId);
    }
    @Override
    @Transactional
    public Activity getActivityDetailToUpdate(long id , String lec_id) {
        return activityDao.getActivityDetailToUpdate(id,lec_id);
    }

    @Override
    @Transactional
    public List<Activity> getActivityDetailByCourseId(long roc_Id) {
        return activityDao.getActivityByRequestOpenCourseId(roc_Id);
    }

    @Override
    @Transactional
    public void updateActivity(Activity activity) {
        activityDao.updateActivity(activity);
    }

    @Override
    @Transactional
    public void deleteActivity(long acId) {
        activityDao.deleteActivity(acId);
    }

    @Override
    @Transactional
    public void deleteCourseActivity(long id , String lec_id){
        activityDao.deleteCourseActivity(id,lec_id);
    }
}
