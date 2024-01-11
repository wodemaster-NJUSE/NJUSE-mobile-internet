package chat.mapper;

import chat.pojo.entity.UserEntity;
import chat.pojo.vo.UserVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    UserVO toUserVO(UserEntity userEntity);
}