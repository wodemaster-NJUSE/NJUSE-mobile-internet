package chat.pojo.request.userRequest;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

@Data
@Schema(description = "发布评论请求")
public class PublishCommentRequest {

    @Schema(description = "动态", required = true)
    @NotNull
    @Size(min = 1, message = "动态编号不能为空")
    @Pattern(regexp = "^[0-9]*$", message = "动态编号只能包含数字")
    private String momentUid;
    @Schema(description = "评论者账号", required = true)
    @NotNull
    @Size(min = 4, max = 16, message = "账号长度必须在 4-16 之间")
    @Pattern(regexp = "^[0-9]*$", message = "账号只能包含数字")
    private String commenterUid;
    @Schema(description = "内容", required = true)
    @NotNull
    @Size(min = 1, message = "消息不能为空")
    private String content;

    @Schema(description = "日期", required = true)
    @NotNull
    private String commentTime;

}
