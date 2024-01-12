package chat.service.impl;

import chat.dao.FriendDao;
import chat.dao.MomentDao;
import chat.dao.UserDao;
import chat.exception.BizError;
import chat.mapper.ChatModelMapper;
import chat.mapper.MomentMapper;
import chat.mapper.UserMapper;
import chat.pojo.Pair;
import chat.pojo.entity.FriendEntity;
import chat.pojo.entity.MomentEntity;
import chat.pojo.entity.UserEntity;
import chat.pojo.object.Comment;
import chat.pojo.object.PersonalInfo;
import chat.pojo.request.userRequest.SettingRequest;
import chat.pojo.vo.ChatModel;
import chat.pojo.vo.MomentModel;
import chat.service.UserService;
import io.exception.BizException;
import io.exception.CommonErrorType;
import io.pojo.CommonResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.util.function.Tuple2;

import java.util.*;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserDao userDao;
    private final FriendDao friendDao;
    private final MomentDao momentDao;
    private final Long base = 100000000L;
    private Long momentCounter = 0L;

    /**
     * 用户注册
     * @param username 用户名
     * @param password 密码
     */
    @Override
    public UserEntity register(String username, String password) {
        long uid_long = userDao.findAll().size() + base;
        String uid = Long.toString(uid_long);

        UserEntity userEntity = UserEntity.builder().username(username).password(password)
                .uid(uid).build();
        userDao.save(userEntity);
        return userEntity;
    }

    /**
     * 根据 uid 查找用户
     * @param uid 账号
     * @return         用户实体
     */
    @Override
    public UserEntity findByUid(String uid) {
        return userDao.findByUid(uid);
    }

    /**
     * 根据 uid 查找用户
     * @return         pair
     */
    @Override
    public Pair<UserEntity,String> searchByUid(String senderUid,String receiverUid) {
        UserEntity senderUser = userDao.findByUid(senderUid);
        UserEntity receiverUser = userDao.findByUid(receiverUid);
        Pair<UserEntity,String> res = new Pair<>(null,"-1");
        if (receiverUser == null)
            res.setSecond("0");
        // 双方已是好友
        else if (receiverUser.getRelationList().contains(senderUid))
            res.setSecond("1");
        // 已向对方发送过过申请
        else if (receiverUser.getFriendRequestList().contains(senderUid))
            res.setSecond("2");
        // 对方已向我发送过申请
        else if(senderUser.getFriendRequestList().contains(senderUid))
            res.setSecond("3");
        // 发送请求成功！
        else
            res.setSecond("4");
        res.setFirst(receiverUser);
        return res;
    }

    /**
     * 用户登录
     * @param uid 账号
     * @param password 密码
     */
    @Override
    public void login(String uid, String password) {
        UserEntity user = userDao.findByUid(uid);
        if (user == null || !password.equals(user.getPassword())) {
            throw new BizException(BizError.INVALID_CREDENTIAL);
        }
    }

    /**
     * 编辑用户信息
     * @param username 用户名
     */
    @Override
    public void editInfo(String uid, String username){
        UserEntity user = userDao.findByUid(uid);
        if(user == null){
            throw new BizException(CommonErrorType.ILLEGAL_ARGUMENTS, "用户不存在");
        }
        userDao.save(user.setUsername(username));
    }

    /**
     * 添加用户
     * @param senderUid   发送者 UID
     * @param receiverUid 接受者 UID
     * @return int 类型，404：未找到用户，405：用户已经是好友，200：正常
     */
    @Override
    public void requestFriend(String senderUid, String receiverUid) {
        UserEntity receiverUser = userDao.findByUid(receiverUid);

        // 发送请求成功！
        receiverUser.getFriendRequestList().add(senderUid);
        userDao.save(receiverUser);
        System.out.println(senderUid + "给" + receiverUid + "发送好友申请");
    }

    @Override
    public List<ChatModel> getRequestFriend(String uid) {
        UserEntity userEntity = userDao.findByUid(uid);
        List<ChatModel> res = new ArrayList<>();
        for(String tmpUid : userEntity.getFriendRequestList()){
//            chatModel = ChatModel.builder().userVO(UserMapper.INSTANCE.toUserVO(findByUid(tmpUid))).build();
//            res.add(chatModel);
            ChatModel chatModel = new ChatModel();
            chatModel.setUser(UserMapper.INSTANCE.toUserVO(findByUid(tmpUid)));
            res.add(chatModel);
        }
        return res;
    }

    @Override
    public void dealRequestFriend(String dealerUid, String senderUid, boolean deal){
        UserEntity dealerEntity = userDao.findByUid(dealerUid);
        UserEntity senderEntity = userDao.findByUid(senderUid);
        if (deal)
        {
            //删除请求
            dealerEntity.getFriendRequestList().remove(senderUid);
            //添加好友类
            FriendEntity dealerFriendEntity = FriendEntity.builder().ownerUid(dealerUid).friendUid(senderUid).note(senderEntity.getUsername()).isFriend(true).unreadMsgCount(0).build();
            FriendEntity senderFriendEntity = FriendEntity.builder().ownerUid(senderUid).friendUid(dealerUid).note(dealerEntity.getUsername()).isFriend(true).unreadMsgCount(0).build();
            dealerEntity.getRelationList().add(senderUid);
            senderEntity.getRelationList().add(dealerUid);
            //保存
            userDao.save(dealerEntity);
            userDao.save(senderEntity);
            friendDao.save(dealerFriendEntity);
            friendDao.save(senderFriendEntity);
        }
        else
        {
            //删除请求
            dealerEntity.getFriendRequestList().remove(senderUid);
            //保存
            userDao.save(dealerEntity);
        }
        System.out.println(dealerUid + "接受了" + senderUid + "的好友申请");
    }

    @Override
    @Transactional
    public void deleteFriend(String senderUid, String receiverUid){
        UserEntity senderEntity = userDao.findByUid(senderUid);
        UserEntity receiverEntity = userDao.findByUid(receiverUid);
        //数据库删除
        friendDao.deleteByOwnerUidAndFriendUid(senderUid, receiverUid);
        friendDao.deleteByOwnerUidAndFriendUid(receiverUid,senderUid);
        //用户实体删除
        senderEntity.getRelationList().removeIf(receiverUid::equals);
        receiverEntity.getRelationList().removeIf(senderUid::equals);
        // 更新用户实体
        userDao.save(senderEntity);
        userDao.save(receiverEntity);
    }
    @Override
    public void publishMoment(MomentModel momentModel){
        ++momentCounter;
        UserEntity userEntity = userDao.findByUid(momentModel.getId());
        userEntity.getMomentList().add(Long.toString(momentCounter));
        //TODO: imageList
        MomentEntity momentEntity = MomentEntity.builder().publisherUid(momentModel.getId()).momentUid(Long.toString(momentCounter)).content(momentModel.getText()).date(momentModel.getTime()).likeCount(0).commentCount(0).
                build();
        momentDao.save(momentEntity);
    }

    @Override
    @Transactional
    public void deleteMoment(String momentUid){
        MomentEntity momentEntity = momentDao.findByMomentUid(momentUid);
        UserEntity userEntity = userDao.findByUid(momentEntity.getPublisherUid());
        //数据库删除
        momentDao.deleteByMomentUid(momentUid);
        //实体删除
        userEntity.getMomentList().removeIf(momentUid::equals);
        //更新
        userDao.save(userEntity);
    }
    @Override
    public void likeMoment(String momentUid, String likerUid){
        MomentEntity momentEntity = momentDao.findByMomentUid(momentUid);
        momentEntity.getLikerList().add(likerUid);
        momentEntity.setLikeCount(momentEntity.getLikeCount()+1);
        momentDao.save(momentEntity);
    }
    @Override
    public void unlikeMoment(String momentUid, String unlikerUid) {
        MomentEntity momentEntity = momentDao.findByMomentUid(momentUid);
        momentEntity.getLikerList().remove(unlikerUid);
        momentEntity.setLikeCount(momentEntity.getLikeCount() - 1);
        momentDao.save(momentEntity);
    }
    @Override
    public void publishComment(String commenterUid, String momentUid, String content, String commentTime){
        Comment comment = new Comment(commenterUid,momentUid,content,commentTime);
        MomentEntity momentEntity = momentDao.findByMomentUid(momentUid);
        momentEntity.getCommentList().add(comment);
        momentEntity.setCommentCount(momentEntity.getCommentCount()+1);
        momentDao.save(momentEntity);
    }
    @Override
    public List<MomentModel> getZoneMomentModels(String uid){
        UserEntity user = userDao.findByUid(uid);
        List<MomentModel> res = new ArrayList<>();
        List<String> uidList = new ArrayList<>();
        uidList.add(uid);
        uidList.addAll(user.getRelationList());
        //
        for (String tmp : uidList)
        {
            UserEntity tmpUser = userDao.findByUid(tmp);
            List<String> momentList = tmpUser.getMomentList();
            for (String momentUid : momentList)
            {
                MomentEntity momentEntity = momentDao.findByMomentUid(momentUid);
                MomentModel momentModel = MomentMapper.INSTANCE.toMomentModel(momentEntity,tmpUser);
                res.add(momentModel);
            }
        }
        res.sort(Comparator.comparing(MomentModel::getTime));
        Collections.reverse(res);
        return res;
    }

    @Override
    public PersonalInfo getPersonalInformation(String uid) {
        UserEntity userEntity = userDao.findByUid(uid);
        PersonalInfo personalInfo = new PersonalInfo();

        // todo：头像
        personalInfo.setUserName(userEntity.getUsername());
        personalInfo.setMotto(userEntity.getMotto());
        personalInfo.setGender(userEntity.getGender());

        return personalInfo;
    }

    @Override
    public void setUserInfo(SettingRequest settingRequest) {
        String uid = settingRequest.getUid();
        UserEntity userEntity = userDao.findByUid(uid);

        userEntity.setUsername(settingRequest.getUserName());
        userEntity.setMotto(settingRequest.getSignature());
        userEntity.setGender(settingRequest.getGender());

        userDao.save(userEntity);
    }

    @Override
    public List<MomentModel> getMomentModels(String uid){
        UserEntity userEntity = userDao.findByUid(uid);
        List<MomentModel> res = new ArrayList<>();
        List<String> momentList = userEntity.getMomentList();
        for (String momentUid : momentList)
        {
            MomentEntity momentEntity = momentDao.findByMomentUid(momentUid);
            MomentModel momentModel = MomentMapper.INSTANCE.toMomentModel(momentEntity,userEntity);
            res.add(momentModel);
        }
        return res;
    }

    /**
     * chatModel返回
     * @param uid 查找用户的uid
     * @return 该用户chatModel
     */
    @Override
    public List<ChatModel> getChatModelList(String uid){
        List<ChatModel> chatModelList = new ArrayList<>();
        UserEntity userEntity = userDao.findByUid(uid);
        UserEntity tempUserEntity;
        FriendEntity tempFriendEntity;
        ChatModel tempChatModel;
        for(int i=0;i<userEntity.getRelationList().size();i++){
            tempUserEntity = userDao.findByUid(userEntity.getRelationList().get(i));
            tempFriendEntity = friendDao.findByOwnerUidAndFriendUid(uid,userEntity.getRelationList().get(i));
            tempChatModel = ChatModelMapper.INSTANCE.toChatModel(tempUserEntity, tempFriendEntity);
            chatModelList.add(tempChatModel);
        }
        return chatModelList;
    }
    /*
    /   返回好友chatModel
     */

    @Override
    public ChatModel getChatModel(String ownerUid, String friendUid){
        UserEntity userEntity = userDao.findByUid(ownerUid);
        FriendEntity friendEntity = friendDao.findByOwnerUidAndFriendUid(ownerUid,friendUid);
        return ChatModelMapper.INSTANCE.toChatModel(userEntity,friendEntity);
    }

}