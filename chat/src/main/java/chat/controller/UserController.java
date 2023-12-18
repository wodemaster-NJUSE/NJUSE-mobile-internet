package chat.controller;


import chat.dao.UserDao;
import chat.pojo.entity.UserEntity;
import chat.pojo.vo.user.LoginRequest;
import chat.pojo.vo.user.RegisterRequest;
import chat.service.UserService;
import io.pojo.CommonResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@CrossOrigin(origins = "http://localhost:5173", allowCredentials = "true")
@RestController
@RequestMapping("/v1/")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private UserDao userDao;

    @PostMapping("session")
    public CommonResponse<UserEntity> login(@Valid @RequestBody LoginRequest request) {
        // Throws BizException if auth failed.
        userService.login(request.getUid(), request.getPassword());
        UserEntity userEntity = userDao.findByUid(request.getUid());
        return CommonResponse.success(userEntity);
    }

    @PostMapping("user")
    public CommonResponse<?> register(@Valid @RequestBody RegisterRequest request) {
        // Throws BizException if register failed.
        userService.register(request.getUsername(), request.getPassword());

        return CommonResponse.success();
    }

    @DeleteMapping("session")
    public CommonResponse<?> logout() {
        return CommonResponse.success(200);
    }


}