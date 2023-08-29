package lifelong.model;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
@Entity
@Table(name = "images")
public class Test_img {
    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ElementCollection
    @CollectionTable(name = "img_names", joinColumns = @JoinColumn(name = "img_id"))
    @Column(name = "img_name")
    private List<String> imgNames = new ArrayList<>();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<String> getImgNames() {
        return imgNames;
    }

    public void setImgNames(List<String> imgNames) {
        this.imgNames = imgNames;
    }
}
