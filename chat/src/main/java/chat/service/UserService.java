package chat.service;

import chat.pojo.entity.UserEntity;

public interface UserService {
    void login(Long uid, String password);
    void register(String username, String password);

    UserEntity findByUid(Long uid);
    void editInfo(Long uid,String username);
}