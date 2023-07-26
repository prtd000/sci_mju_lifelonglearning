package lifelong.service;

import lifelong.dao.LecturerDao;
import lifelong.model.Lecturer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LecturerServiceImpl implements LecturerService {

    @Autowired
    private LecturerDao lecturerDao;

    @Override
    @Transactional
    public Lecturer getLecturerById(String username) {
        return lecturerDao.getLecturerById(username);
    }
}
