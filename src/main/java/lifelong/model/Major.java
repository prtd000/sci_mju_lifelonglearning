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


}
