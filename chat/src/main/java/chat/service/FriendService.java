package chat.service;

import chat.pojo.vo.MessageBase;

import java.util.Date;
import java.util.List;

public interface FriendService {
    void sendMessage(MessageBase messageBase);


    List<MessageBase> getMessages(String senderUid, String receiverUid);
}
