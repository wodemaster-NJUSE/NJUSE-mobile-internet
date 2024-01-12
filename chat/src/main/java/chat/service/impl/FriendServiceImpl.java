package chat.service.impl;

import chat.dao.FriendDao;
import chat.dao.UserDao;
import chat.mapper.UserMapper;
import chat.pojo.entity.FriendEntity;
import chat.pojo.object.ChatMessage;
import chat.pojo.vo.MessageBase;
import chat.pojo.vo.UserVO;
import chat.service.FriendService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FriendServiceImpl implements FriendService {
    private final FriendDao friendDao;
    private final UserDao userDao;

    @Override
    public void sendMessage(MessageBase messageBase) {
//          TODO 消息已读或未读逻辑还未实现，等待前端
//        FriendEntity senderEntity = friendDao.findByOwnerUidAndFriendUid(senderUid,receiverUid);
//        FriendEntity receiverEntity = friendDao.findByOwnerUidAndFriendUid(receiverUid,senderUid);
//        Text text = new Text(senderUid,receiverUid,message,date);
//        senderEntity.getMessages().add(text);
//        receiverEntity.getMessages().add(text);
//        //添加未读消息
//        receiverEntity.setUnreadMsgCount(receiverEntity.getUnreadMsgCount()+1);
//        //
//        friendDao.save(senderEntity);
//        friendDao.save(receiverEntity);
        UserVO from = messageBase.getFrom();
        UserVO to   = messageBase.getTo();
        FriendEntity senderEntity = friendDao.findByOwnerUidAndFriendUid(from.getUserId(),to.getUserId());
        FriendEntity receiverEntity = friendDao.findByOwnerUidAndFriendUid(to.getUserId(),from.getUserId());
        ChatMessage text = new ChatMessage(from.getUserId(),to.getUserId(),messageBase.getMsgBody(),messageBase.getMsgTime(),messageBase.getMsgType());
        senderEntity.getMessages().add(text);
        receiverEntity.getMessages().add(text);
        //添加未读消息
        receiverEntity.setUnreadMsgCount(receiverEntity.getUnreadMsgCount()+1);
        //
        friendDao.save(senderEntity);
        friendDao.save(receiverEntity);
        System.out.println("发送消息的时间" + messageBase.getMsgTime());
    }

    @Override
    public List<MessageBase> getMessages(String senderUid, String receiverUid){
        FriendEntity senderEntity = friendDao.findByOwnerUidAndFriendUid(senderUid,receiverUid);
        //重置未读消息
        FriendEntity receiverEntity = friendDao.findByOwnerUidAndFriendUid(receiverUid,senderUid);
        senderEntity.setUnreadMsgCount(0);
        //保存
        friendDao.save(senderEntity);

        List<ChatMessage> textList = senderEntity.getMessages();
        List<MessageBase> res = new ArrayList<>();
        for (ChatMessage x : textList){
            MessageBase messageBase = new MessageBase();
            UserVO from = UserMapper.INSTANCE.toUserVO(userDao.findByUid(x.getSenderUid()));
            UserVO to = UserMapper.INSTANCE.toUserVO(userDao.findByUid(x.getReceiverUid()));
            messageBase.setFrom(from);
            messageBase.setTo(to);
            messageBase.setMsgId(" ");
            messageBase.setMsgTime(x.getTime());
            messageBase.setMsgType(x.getType());
            messageBase.setMsgBody(x.getMessage());
            //
            res.add(messageBase);
        }
        return res;
    }

}
