package lifelong.model;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "member")
public class Member {

    @Id
    @Column(name = "mem_username",length = 10)
    private String username;

    @Column(name = "mem_password",nullable = false,length = 16)
    private String password;

    @Column(name = "mem_idcard",nullable = false,length = 20)
    private String idcard;

    @Column(name = "mem_firstName",nullable = false,length = 100)
    private String firstName;

    @Column(name = "mem_lastName",nullable = false,length = 150)
    private String lastName;

    @Column(name = "mem_gender",nullable = false,length = 50)
    private String gender;

    @Column(name = "mem_birthday")
    private Date birthday;

    @Column(name = "mem_email",nullable = false,length = 200)
    private String email;

    @Column(name = "mem_tel",nullable = false,length = 20)
    private String tel;

    @Column(name = "mem_education",length = 200)
    private String education;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "mem_username",nullable = false)
    private Set<Register> register = new HashSet<>();

    public Member() {
    }

    public Member(String username, String password, String idcard, String firstName, String lastName, String gender, Date birthday, String email, String tel, String education) {
        this.username = username;
        this.password = password;
        this.idcard = idcard;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.birthday = birthday;
        this.email = email;
        this.tel = tel;
        this.education = education;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }
}
