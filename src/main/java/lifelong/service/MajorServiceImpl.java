package lifelong.service;

import lifelong.dao.MajorDao;
import lifelong.model.Major;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Repository
public class MajorServiceImpl implements MajorService{
    @Autowired
    private MajorDao majorDao;
    @Override
    @Transactional
    public List<Major> getMajors() {
        return majorDao.getMajors();
    }
}
