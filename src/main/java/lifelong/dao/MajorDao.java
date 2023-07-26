package lifelong.dao;

import lifelong.model.Course;
import lifelong.model.Major;
import java.util.List;

public interface MajorDao {
    Major getMajorDetail(String id);
    List<Major> getMajors();

}
