package chat.pojo.request.userRequest;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.*;

@Data
@Schema(description = "注册请求")
public class RegisterRequest {

    @Schema(description = "用户名", required = true)
    @NotNull
    @Size(min = 4, max = 16, message = "用户名长度必须在 4-16 之间")
    @Pattern(regexp = "^[A-Za-z\\d-_]*$", message = "用户名只能包含字母,数字,下划线和连字符")
    private String username;

    @Schema(description = "密码", required = true)
    @NotNull
    @Size(min = 8, max = 56, message = "密码长度必须在 8-56 之间")
    @Pattern.List({
            @Pattern(regexp = "^[\\x21-\\x7e]*$", message = "密码只能包含字母,数字和符号"),
            @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).*$", message = "密码未达到复杂性要求:密码必须包含大小写字母和数字")
    })
    private String password;
}
