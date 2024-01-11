package chat.service.impl;

import chat.dao.FriendDao;
import chat.pojo.entity.FriendEntity;
import chat.pojo.object.Text;
import chat.pojo.vo.MessageBase;
import chat.pojo.vo.UserVO;
import chat.service.FriendService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FriendServiceImpl implements FriendService {
    private final FriendDao friendDao;

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
        FriendEntity senderEntity = friendDao.findByOwnerUidAndFriendUid(from.getUid(),to.getUid());
        FriendEntity receiverEntity = friendDao.findByOwnerUidAndFriendUid(to.getUid(),from.getUid());
        Text text = new Text(from.getUid(),to.getUid(),messageBase.getMsgBody(),messageBase.getMsgTime(),messageBase.getMsgType());
        senderEntity.getMessages().add(text);
        receiverEntity.getMessages().add(text);
        //添加未读消息
        receiverEntity.setUnreadMsgCount(receiverEntity.getUnreadMsgCount()+1);
        //
        friendDao.save(senderEntity);
        friendDao.save(receiverEntity);
    }

    @Override
    public List<Text> getMessages(String senderUid, String receiverUid){
        FriendEntity senderEntity = friendDao.findByOwnerUidAndFriendUid(senderUid,receiverUid);
        //重置未读消息
        FriendEntity receiverEntity = friendDao.findByOwnerUidAndFriendUid(receiverUid,senderUid);
        receiverEntity.setUnreadMsgCount(0);
        //保存
        friendDao.save(receiverEntity);
        return senderEntity.getMessages();
    }

}
