package chat.mapper;

import chat.pojo.entity.MomentEntity;
import chat.pojo.entity.UserEntity;
import chat.pojo.vo.MomentModel;
import chat.pojo.vo.UserVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.factory.Mappers;

@Mapper
public interface MomentMapper {
    MomentMapper INSTANCE = Mappers.getMapper(MomentMapper.class);

    @Mapping(source = "momentEntity.momentUid", target = "id")
    @Mapping(source = "userEntity", target = "user",qualifiedByName = "buildUserVO")
    @Mapping(source = "momentEntity.content", target = "text")
    @Mapping(source = "momentEntity.date", target = "time")
    MomentModel toMomentModel(MomentEntity momentEntity,UserEntity userEntity);

    @Named("buildUserVO")
    default UserVO buildUserVO(UserEntity userEntity) {
        UserVO userVO = new UserVO();
        userVO.setUserId(userEntity.getUid());
        userVO.setUserImage(userEntity.getAvatar());
        userVO.setUserName(userEntity.getUsername());
        return userVO;
    }
}
