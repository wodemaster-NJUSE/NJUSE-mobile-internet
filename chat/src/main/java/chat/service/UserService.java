package chat.service;

import chat.pojo.entity.UserEntity;

public interface UserService {
    void login(String uid, String password);
    void register(String username, String password);

    UserEntity findByUid(String uid);
    void editInfo(String uid,String username);
}