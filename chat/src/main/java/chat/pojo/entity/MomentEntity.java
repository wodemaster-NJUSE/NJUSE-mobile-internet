package chat.pojo.entity;

import chat.pojo.object.Comment;
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
@Embeddable
@NoArgsConstructor
@Accessors(chain = true)
public class MomentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private String publisherUid;
    @NotNull
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String momentUid;
    @NotNull
    private String content;
    @NotNull
    private String date;

    private int likeCount;

    private int commentCount;
    @ElementCollection
    private List<String> likerList;

    @ElementCollection
    private List<Comment> commentList;

    @ElementCollection
    private List<String> imageList;

//    private String momentUid;
//
//    private String uid;
//
//    private String content;
//
//    private String time;
}
