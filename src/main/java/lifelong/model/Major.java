package lifelong.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "major")
public class Major {

    @Id
    @Column(nullable = false,length = 10)
    private String major_id;

    @Column(name = "major_name",nullable = false,length = 150)
    private String name;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "major_id",nullable = false)
    private Set<Lecturer> lecturers = new HashSet<>();

    public String getMajor_id() {
        return major_id;
    }

    public void setMajor_id(String major_id) {
        this.major_id = major_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Lecturer> getLecturers() {
        return lecturers;
    }

    public void setLecturers(Set<Lecturer> lecturers) {
        this.lecturers = lecturers;
    }
}
