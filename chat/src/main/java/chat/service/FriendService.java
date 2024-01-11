package chat.service;

import chat.pojo.object.Text;
import chat.pojo.vo.MessageBase;

import java.util.Date;
import java.util.List;

public interface FriendService {
    void sendMessage(MessageBase messageBase);


    List<Text> getMessages(String senderUid, String receiverUid);
}
