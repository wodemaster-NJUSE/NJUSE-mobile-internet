package chat.pojo.object;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class Text {
    @NotNull
    private String senderUid;
    @NotNull
    private String receiverUid;
    @NotNull
    private String message;
    @NotNull
    private String date;
    @NotNull
    private String type;
}
