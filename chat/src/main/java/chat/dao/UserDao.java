package chat.dao;

import chat.pojo.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDao extends JpaRepository<UserEntity, Long> {
    UserEntity findByUid(String uid);
}