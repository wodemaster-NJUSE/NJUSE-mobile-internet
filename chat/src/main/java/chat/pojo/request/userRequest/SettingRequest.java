package chat.pojo.request.userRequest;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class SettingRequest {
    @NotNull
    String uid;

    String data;
}
