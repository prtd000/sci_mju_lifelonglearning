package lifelong.service;

import lifelong.dao.LecturerDao;
import lifelong.dao.MajorDao;
import lifelong.model.Lecturer;
import lifelong.model.Major;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class LecturerServiceImpl implements LecturerService{
    @Autowired
    private LecturerDao lecturerDao;
    @Override
    @Transactional
    public List<Lecturer> getLecturer() {
        return lecturerDao.getLecturer();
    }
}
