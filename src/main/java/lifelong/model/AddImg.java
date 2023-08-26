package lifelong.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "imgs")
public class AddImg {
    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    private long id;

    @Column
    private String detail;

//    @ElementCollection
//    @CollectionTable(name = "img_names", joinColumns = @JoinColumn(name = "img_id"))
//    @Column(name = "img")
//    private List<String> imgNames = new ArrayList<>();

    @Column(columnDefinition = "TEXT") // ใช้ TEXT สำหรับเก็บ JSON ในฐานข้อมูล
    private String imgNamesJson; // เก็บสตริง JSON ของรายชื่อไฟล์ภาพ
    public AddImg() {
    }

    public AddImg(long id, String detail, String imgNamesJson) {
        this.id = id;
        this.detail = detail;
        this.imgNamesJson = imgNamesJson;
    }

    public AddImg(String detail, String imgNamesJson) {
        this.detail = detail;
        this.imgNamesJson = imgNamesJson;
    }

    //    public AddImg(long id, String detail, List<String> imgNames) {
//        this.id = id;
//        this.detail = detail;
//        this.imgNames = imgNames;
//    }
//
//    public AddImg(String detail, List<String> imgNames) {
//        this.detail = detail;
//        this.imgNames = imgNames;
//    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

//    public List<String> getImgNames() {
//        return imgNames;
//    }
//
//    public void setImgNames(List<String> imgNames) {
//        this.imgNames = imgNames;
//    }

    public String getImgNamesJson() {
        return imgNamesJson;
    }

    public void setImgNamesJson(String imgNamesJson) {
        this.imgNamesJson = imgNamesJson;
    }
}

