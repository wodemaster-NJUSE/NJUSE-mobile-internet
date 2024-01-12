package chat.pojo.entity;

import chat.pojo.object.ChatMessage;
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
public class FriendEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private String ownerUid;
    @NotNull
    private String friendUid;

    private String note;

    private boolean isFriend;

    @ElementCollection
    private List<ChatMessage> messages;
//
//    //最后一条信息
//    private String lastMsg;

    /**
     * 未读消息数量
     */
    private int unreadMsgCount;
}
