package chat.dao;

import chat.pojo.entity.FriendEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FriendDao extends JpaRepository<FriendEntity, Long> {

    void deleteByOwnerUidAndFriendUid(String ownerUid,String friendUid);

    FriendEntity findByOwnerUidAndFriendUid(String ownerUid,String friendUid);
}
