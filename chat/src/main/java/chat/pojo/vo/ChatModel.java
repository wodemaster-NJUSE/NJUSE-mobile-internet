package chat.pojo.vo;

import lombok.Data;

@Data
public class ChatModel {

//    private UserVO;
//    lastMsg: string
//    lastTime: string
//    unreadMsgCount: number

    private UserVO user;
    private String lastMsg;
    private String lastTime;
    private int unreadMsgCount;
}
