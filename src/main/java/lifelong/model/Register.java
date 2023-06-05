package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="register")
public class Register {

    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private String register_id;

    @Column(nullable = false)
    private Date register_date;

    @Column(nullable = false)
    private Boolean study_result;

}
