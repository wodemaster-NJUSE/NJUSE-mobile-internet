package chat.service;

import chat.pojo.Pair;
import chat.pojo.entity.UserEntity;
import chat.pojo.object.PersonalInfo;
import chat.pojo.request.userRequest.SettingRequest;
import chat.pojo.vo.ChatModel;
import chat.pojo.vo.MomentModel;

import java.util.List;

public interface UserService {
    void login(String uid, String password);
    UserEntity register(String username, String password);

    UserEntity findByUid(String uid);

    Pair<UserEntity,String> searchByUid(String senderUid,String receiverUid);

    void editInfo(String uid,String username);

    void requestFriend(String senderUid, String receiverUid);

    List<ChatModel> getRequestFriend(String uid);

    void dealRequestFriend(String dealerUid, String senderUid, boolean deal);

    void deleteFriend(String senderUid, String receiverUid);

    void publishMoment(MomentModel momentModel);

    void deleteMoment(String momentUid);
    void likeMoment(String momentUid,String likerUid);
    void unlikeMoment(String momentUid, String unlikerUid);
    void publishComment(String commenterUid, String momentUid, String content, String commentTime);

    List<MomentModel> getZoneMomentModels(String uid);

    List<MomentModel> getMomentModels(String uid);

    PersonalInfo getPersonalInformation(String uid);

    void setUserInfo(SettingRequest settingRequest);


    List<ChatModel> getChatModelList(String uid);

    ChatModel getChatModel(String ownerUid, String friendUid);
}