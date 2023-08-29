package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Test_img;

public interface TestDao {
    void doAddImg(Test_img testImg);

    int max_id();
}
