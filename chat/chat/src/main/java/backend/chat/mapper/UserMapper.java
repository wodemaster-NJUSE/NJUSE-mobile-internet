package backend.chat.mapper;

import backend.chat.pojo.entity.UserEntity;
import backend.chat.pojo.vo.user.UserVO;

import org.apache.ibatis.annotations.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    UserVO toUserVO(UserEntity userEntity);
}