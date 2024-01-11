package chat.pojo.request.friendRequest;

import chat.pojo.vo.MessageBase;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

@Data
@Schema(description = "发送消息请求")
public class SendMessageRequest {
    @NotNull
    private MessageBase messageBase;
}
