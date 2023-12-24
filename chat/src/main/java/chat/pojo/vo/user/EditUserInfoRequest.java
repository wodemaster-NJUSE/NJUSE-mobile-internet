package chat.pojo.vo.user;

import io.swagger.v3.oas.annotations.media.Schema;

import lombok.Data;

import javax.validation.constraints.*;

@Data
@Schema(description = "修改用户信息请求")
public class EditUserInfoRequest {

    @Schema(description = "姓名", required = true)
    @NotNull
    @Size(min = 2, max = 16, message = "姓名长度必须在 2-16 之间")
    @Pattern.List({
            @Pattern(regexp = "^[\\u4E00-\\u9FA5]{2,16}$", message = "姓名只能包含中文"),
    })
    private String name;


}
