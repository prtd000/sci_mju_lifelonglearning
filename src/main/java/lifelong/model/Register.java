package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="register")
public class Register {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //Auto Increment
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(length = 10)
    private int register_id;

    @Column(nullable = false)
    private Date register_date;

    @Column(nullable = false)
    private Boolean study_result;

}
