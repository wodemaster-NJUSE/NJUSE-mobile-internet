package chat.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface FriendMapper {
    FriendMapper INSTANCE = Mappers.getMapper(FriendMapper.class);

    //FriendVO toUserVO(FriendEntity userEntity);
}
