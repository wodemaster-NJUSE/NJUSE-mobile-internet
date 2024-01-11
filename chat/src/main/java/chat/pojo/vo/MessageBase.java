package chat.pojo.vo;

import lombok.Data;

@Data
public class MessageBase {
    private String msgId;

    private UserVO from;

    private UserVO to;

    private String msgBody;

    private String msgType;

    private String msgTime;
}
