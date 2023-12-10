package backend.chat.service;

import backend.chat.pojo.entity.UserEntity;

public interface UserService {
    void login(String username, String password);
    void register(String username, String password);

    UserEntity findByUserName(String username);
    void editInfo(String username);
}