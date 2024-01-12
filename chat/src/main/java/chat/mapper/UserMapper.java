package chat.mapper;

import chat.pojo.entity.UserEntity;
import chat.pojo.vo.UserVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    @Mapping(source = "userEntity.uid", target = "userId")
    @Mapping(source = "userEntity.username", target = "userName")
    @Mapping(source = "userEntity.avatar", target = "userImage")
    UserVO toUserVO(UserEntity userEntity);
}