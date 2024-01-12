package chat.pojo.object;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class ChatMessage {
    @NotNull
    private String senderUid;
    @NotNull
    private String receiverUid;
    @NotNull
    private String message;
    @NotNull
    private String time;
    @NotNull
    private String type;
}
