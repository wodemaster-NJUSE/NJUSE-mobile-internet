package chat.pojo.request.friendRequest;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Data
@Schema(description = "获取消息列表请求的请求")
public class GetMessagesRequest {
    @Schema(description = "账号", required = true)
    @NotNull
    @Size(min = 4, max = 16, message = "账号长度必须在 4-16 之间")
    @Pattern(regexp = "^[0-9]*$", message = "账号只能包含数字")
    private String ownerUid;

    @Schema(description = "账号", required = true)
    @NotNull
    @Size(min = 4, max = 16, message = "账号长度必须在 4-16 之间")
    @Pattern(regexp = "^[0-9]*$", message = "账号只能包含数字")
    private String friendUid;
}
