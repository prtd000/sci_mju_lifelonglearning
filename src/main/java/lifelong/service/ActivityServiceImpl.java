package lifelong.service;

import lifelong.dao.ActivityDao;
import lifelong.dao.CouresDao;
import lifelong.model.Activity;
import lifelong.model.Course;
import lifelong.model.RequestOpenCourse;
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
    public void updateActivity(Activity activity) {
        activityDao.updateActivity(activity);
    }

    @Override
    @Transactional
    public void deleteActivity(long acId) {
        activityDao.deleteActivity(acId);
    }
}
