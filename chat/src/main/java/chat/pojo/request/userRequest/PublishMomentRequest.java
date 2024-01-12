package chat.pojo.request.userRequest;

import chat.pojo.vo.MomentModel;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

@Data
@Schema(description = "发布动态请求")
public class PublishMomentRequest {

    @NotNull
    private MomentModel momentModel;
}
