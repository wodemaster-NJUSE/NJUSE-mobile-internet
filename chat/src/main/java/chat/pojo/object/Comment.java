package chat.pojo.object;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class Comment {
    @NotNull
    private String commenterUid;
    @NotNull
    private String momentId;
    @NotNull
    private String content;
    @NotNull
    private String commentTime;
}
