package lifelong.service;

import lifelong.model.Course;
import lifelong.model.Major;

import java.util.List;

public interface MajorService {
    Major getMajorDetail(String majorId);
    List<Major> getMajors();
}
