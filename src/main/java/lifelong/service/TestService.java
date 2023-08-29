package lifelong.service;

import lifelong.model.Test_img;

public interface TestService {
    void doAddImg(Test_img testImg);

    int max_id();
}
