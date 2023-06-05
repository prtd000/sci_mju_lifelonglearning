package lifelong.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "admin")
public class Admin {

    @Id
    @Column(name = "admin_username",nullable = false,length = 10)
    private String username;

    @Column(name = "admin_password",nullable = false,length = 16)
    private String password;
}
