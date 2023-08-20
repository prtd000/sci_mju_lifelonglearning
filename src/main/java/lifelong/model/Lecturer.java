package lifelong.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name="lecturer")
public class Lecturer {

    @Id
    @Column(name = "lec_username",nullable = false,length = 10)
    private String username;

    @Column(name = "lec_password",nullable = false,length = 225)
    private String password;

    @Column(name = "lec_idcard",nullable = false,length = 20)
    private String idcard;

    @Column(name = "lec_position",nullable = false,length = 150)
    private String position;

    @Column(name = "lec_firstName",nullable = false,length = 100)
    private String firstName;

    @Column(name = "lec_lastName",nullable = false,length = 150)
    private String lastName;

    @Column(name = "lec_tel",nullable = false,length = 20)
    private String tel;

    @Column(name = "lec_email",nullable = false,length = 200)
    private String email;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "major_id")
    private Major major;

    public Lecturer() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Major getMajor() {
        return major;
    }

    public void setMajor(Major major) {
        this.major = major;
    }
}
