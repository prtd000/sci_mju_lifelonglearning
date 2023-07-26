package lifelong.dao;

import lifelong.model.Lecturer;

import java.util.List;

public interface LecturerDao {

    List<Lecturer> getAllLecturers ();
    Lecturer getLecturerById (String lecturerId);

    void addLecturer (Lecturer lecturer);
    void updateLecturer (Lecturer lecturer);
    void deleteLecturer (String lecturerId);

}
