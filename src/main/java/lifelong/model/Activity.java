package lifelong.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "activity")
public class Activity {

    @Id
    @Column(length = 10)
    private String ac_id;

    @Column(name = "ac_name",nullable = false)
    private String name;

    @Column(name = "ac_date",nullable = false)
    private Date date;

    @Column(name = "ac_detail",nullable = false)
    private String detail;

    @Column(name = "ac_type",nullable = false,length = 150)
    private String type;

    @Column(name = "ac_img",nullable = false,length = 200)
    private String img;
}
