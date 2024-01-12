package chat.pojo.object;

import lombok.Data;
import reactor.util.annotation.Nullable;

import javax.validation.constraints.NotNull;
import java.sql.Blob;

@Data
public class PersonalInfo {
    @NotNull
    private String userName;

    private String motto;

    private String gender;

    //TODO: 头像信息的获取
}
