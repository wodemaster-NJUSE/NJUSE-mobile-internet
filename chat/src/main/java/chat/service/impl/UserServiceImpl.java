package chat.service.impl;

import chat.dao.UserDao;
import chat.exception.BizError;
import chat.pojo.entity.UserEntity;
import chat.service.UserService;
import io.exception.BizException;
import io.exception.CommonErrorType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserDao userDao;
    private final Long base = 100000000L;

    /**
     * 用户注册
     * @param username 用户名
     * @param password 密码
     */
    @Override
    public void register(String username, String password) {
        Long uid_long = userDao.findAll().size() + base;
        String uid =uid_long.toString();

        userDao.save(UserEntity.builder().username(username).password(password)
                .uid(uid).build());
    }

    /**
     * 根据 uid 查找用户
     * @param uid 账号
     * @return         用户实体
     */
    @Override
    public UserEntity findByUid(String uid) {
        return userDao.findByUid(uid);
    }

    /**
     * 用户登录
     * @param uid 账号
     * @param password 密码
     */
    @Override
    public void login(String uid, String password) {
        UserEntity user = userDao.findByUid(uid);
        if (user == null || !password.equals(user.getPassword())) {
            throw new BizException(BizError.INVALID_CREDENTIAL);
        }
    }

    /**
     * 编辑用户信息
     * @param username 用户名
     */
    @Override
    public void editInfo(String uid, String username){
        UserEntity user = userDao.findByUid(uid);
        if(user == null){
            throw new BizException(CommonErrorType.ILLEGAL_ARGUMENTS, "用户不存在");
        }
        userDao.save(user.setUsername(username));
    }
}