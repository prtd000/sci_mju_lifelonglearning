package lifelong.service;

import lifelong.dao.TestDao;
import lifelong.model.Test_img;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TestServiceImpl implements TestService{
    @Autowired
    private TestDao testDao;

    @Override
    @Transactional
    public void doAddImg(Test_img testImg) {
        testDao.doAddImg(testImg);
    }

    @Override
    @Transactional
    public int max_id() {
        return testDao.max_id();
    }
}
