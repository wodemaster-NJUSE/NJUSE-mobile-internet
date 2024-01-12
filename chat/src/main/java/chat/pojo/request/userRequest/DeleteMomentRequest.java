package chat.pojo.request.userRequest;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

@Data
@Schema(description = "删除动态请求")
public class DeleteMomentRequest {

    @Schema(description = "动态", required = true)
    @NotNull
    @Size(min = 1, message = "动态编号不能为空")
    @Pattern(regexp = "^[0-9]*$", message = "动态编号只能包含数字")
    private String momentUid;
}
