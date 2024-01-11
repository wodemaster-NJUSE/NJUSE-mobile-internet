package chat.pojo.vo;

import lombok.Data;

@Data
public class ChatModel {

//    private UserVO userVO;
//    lastMsg: string
//    lastTime: string
//    unreadMsgCount: number

    private UserVO userVO;
    private String lastMsg;
    private String lastTime;
    private int unreadMsgCount;
}
