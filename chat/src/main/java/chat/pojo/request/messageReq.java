package chat.pojo.request;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class messageReq {
    @NotNull
    private String UID;

    @NotNull
    private String question;
}
