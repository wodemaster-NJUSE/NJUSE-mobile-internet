package chat.mapper;

import chat.pojo.entity.FriendEntity;
import chat.pojo.entity.UserEntity;
import chat.pojo.vo.ChatModel;
import chat.pojo.vo.UserVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.factory.Mappers;


@Mapper
public interface ChatModelMapper {
    ChatModelMapper INSTANCE = Mappers.getMapper(ChatModelMapper.class);

    @Mapping(source = "userEntity", target = "user", qualifiedByName = "buildUserVO")
    @Mapping(source = "friendEntity.unreadMsgCount", target = "unreadMsgCount")
    @Mapping(source = "friendEntity",target = "lastMsg",qualifiedByName = "buildLastMsg")
    @Mapping(source = "friendEntity",target = "lastTime",qualifiedByName = "buildLastTime")
    ChatModel toChatModel(UserEntity userEntity, FriendEntity friendEntity);

    @Named("buildUserVO")
    default UserVO buildUserVO(UserEntity userEntity) {
        UserVO userVO = new UserVO();
        userVO.setUserId(userEntity.getUid());
        userVO.setUserImage(userEntity.getAvatar());
        userVO.setUserName(userEntity.getUsername());
        return userVO;
    }
    @Named("buildLastMsg")
    default String buildLastMsg(FriendEntity friendEntity){
        if(friendEntity.getMessages().isEmpty())
            return "你们已经是好友了快去打个招呼吧";
        return friendEntity.getMessages().get(friendEntity.getMessages().size() - 1).getMessage();
    }

    @Named("buildLastTime")
    default String buildLastTime(FriendEntity friendEntity){
        if(friendEntity.getMessages().isEmpty())
            return "刚刚";
        return friendEntity.getMessages().get(friendEntity.getMessages().size() - 1).getTime();
    }
}
