package chat.pojo.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;


@Entity
@Table
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
@Accessors(chain = true)
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String username;
    @NotNull
    private String password;
    @NotNull
    @Column(unique = true)
    private String uid;
    //TODO: set方法还没实现
    private String avatar;

    private String gender;

    private String motto;

    /**
     * 好友列表,存储 UID
     */
    @ElementCollection
    private List<String> relationList;

    @ElementCollection
    private List<String> friendRequestList;

    @ElementCollection
    private List<String> momentList;
    //TODO:private String photoUrl;
}
