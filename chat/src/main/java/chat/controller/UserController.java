package chat.controller;

import chat.pojo.Pair;
import chat.pojo.entity.UserEntity;
import chat.pojo.object.PersonalInfo;
import chat.pojo.request.userRequest.*;
import chat.pojo.vo.ChatModel;
import chat.pojo.vo.MomentModel;
import chat.service.UserService;
import io.pojo.CommonResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@CrossOrigin(origins = "http://localhost:5173", allowCredentials = "true")
@RestController
@RequestMapping("/v1/")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @PostMapping("login")
    public CommonResponse<?> login(@Valid @RequestBody LoginRequest request) {
        // Throws BizException if auth failed.
        userService.login(request.getUid(), request.getPassword());
        UserEntity userEntity = userService.findByUid(request.getUid());
        if(userEntity == null) {
            return CommonResponse.failure(400);
        } else{
            CommonResponse<UserEntity> commonResponse = CommonResponse.success(userEntity);
            commonResponse.setCode(200);
            return commonResponse;
        }
    }

    @PostMapping("register")
    public CommonResponse<String> register(@Valid @RequestBody RegisterRequest request, BindingResult bindingResult) {
        // Throws BizException if register failed.
        if (bindingResult.hasErrors()) {
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            StringBuilder sb = new StringBuilder();
            for (FieldError fieldError : fieldErrors)
                sb.append(fieldError.getDefaultMessage()).append(";");

            CommonResponse<String> commonResponse = CommonResponse.failure(400);
            commonResponse.setMessage(sb.toString());
            return commonResponse;
        }
        else
        {
            UserEntity userEntity = userService.register(request.getUsername(), request.getPassword());
            CommonResponse<String> commonResponse = CommonResponse.success(userEntity.getUid());
            commonResponse.setCode(200);
            commonResponse.setMessage("注册成功");
            return commonResponse;
        }
    }

    @GetMapping("/find")
    public ResponseEntity<CommonResponse<UserEntity>> searchByUid(@RequestParam("senderUid") String senderUid,@RequestParam("receiverUid") String receiverUid) {
        Pair<UserEntity,String> pair = userService.searchByUid(senderUid,receiverUid);
        if (pair.getFirst() != null) {
            CommonResponse<UserEntity> commonResponse = CommonResponse.success(pair.getFirst());
            commonResponse.setMessage(pair.getSecond());
            return ResponseEntity.ok(commonResponse);
        } else {
            CommonResponse<UserEntity> commonResponse = CommonResponse.failure(null);
            commonResponse.setMessage(pair.getSecond());
            return ResponseEntity.ok(commonResponse);
        }
    }

    @DeleteMapping("logout")
    public CommonResponse<?> logout() {
        return CommonResponse.success(200);
    }

    @PostMapping("requestFriend")
    public CommonResponse<ChatModel> requestfriend(@Valid @RequestBody MakeFriendRequest request){
        userService.requestFriend(request.getSenderUid(), request.getReceiverUid());
        CommonResponse<ChatModel> commonResponse = new CommonResponse<>();
        commonResponse.setCode(200);
        return commonResponse;
    }

    @GetMapping("/getRequestFriend")
    public ResponseEntity<CommonResponse<List<ChatModel>>> getRequestFriend(@RequestParam("uid") String uid) {
        List<ChatModel> requestFriends = userService.getRequestFriend(uid);
        if (requestFriends != null) {
            CommonResponse<List<ChatModel>> commonResponse = CommonResponse.success(requestFriends);
            return ResponseEntity.ok(commonResponse);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PatchMapping("dealRequestFriend")
    public CommonResponse<?> dealrequestfriend(@Valid @RequestBody DealRequestFriendRequest request){
        userService.dealRequestFriend(request.getDealerUid(), request.getSenderUid(), request.getDeal());
        return CommonResponse.success(200);
    }

    @DeleteMapping("deleteFriend")
    public CommonResponse<?> deletefriend(@Valid @RequestBody DeleteFriendRequest request)
    {
        userService.deleteFriend(request.getSenderUid(),request.getReceiverUid());
        return CommonResponse.success(200);
    }

    @PostMapping("publishMoment")
    public CommonResponse<?> publishMoment(@Valid @RequestBody PublishMomentRequest request){
        userService.publishMoment(request.getMomentModel());
        return  CommonResponse.success(200);
    }

//    删除动态
//    @DeleteMapping("deleteMoment")
//    public CommonResponse<?> deleteMoment(@Valid @RequestBody DeleteMomentRequest request){
//        userService.deleteMoment(request.getMomentUid());
//        return CommonResponse.success(200);
//    }
    @PostMapping("likeMoment")
    public CommonResponse<?> likeMoment(@Valid @RequestBody LikeMomentRequest request){
        userService.likeMoment(request.getMomentUid(),request.getLikerUid());
        return CommonResponse.success(200);
    }
    @PostMapping("unlikeMoment")
    public CommonResponse<?> unlikeMoment(@Valid @RequestBody UnlikeMomentRequest request){
        userService.unlikeMoment(request.getMomentUid(),request.getUnlikerUid());
        return CommonResponse.success(200);
    }

    @PostMapping("publishComment")
    public CommonResponse<?> publishComment(@Valid @RequestBody PublishCommentRequest request){
        userService.publishComment(request.getCommenterUid(),request.getMomentUid(),request.getContent(),request.getCommentTime());
        return CommonResponse.success(200);
    }

    @GetMapping("setting")
    public CommonResponse<PersonalInfo> setting(@Valid @RequestParam("uid") String uid) {
        CommonResponse<PersonalInfo> commonResponse = new CommonResponse<>();
        commonResponse.setCode(200);
        commonResponse.setData(userService.getPersonalInformation(uid));
        return commonResponse;
    }

    @PostMapping("setting/setUserName")
    public CommonResponse<?> setUserName(@Valid @RequestBody SettingRequest settingRequest) {
        assert settingRequest.getData() != null;
        userService.setUserName(settingRequest.getUid(), settingRequest.getData());
        return CommonResponse.success(200);
    }

    @PostMapping("setting/setMotto")
    public CommonResponse<?> setMotto(@Valid @RequestBody SettingRequest settingRequest) {
        userService.SetMotto(settingRequest.getUid(), settingRequest.getData());
        return CommonResponse.success(200);
    }

    @PostMapping("setting/setGender")
    public CommonResponse<?> setGender(@Valid @RequestBody SettingRequest settingRequest) {
        userService.SetGender(settingRequest.getUid(), settingRequest.getData());
        return CommonResponse.success(200);
    }
    @GetMapping("/getZoneMomentModels")
    public ResponseEntity<CommonResponse<List<MomentModel>>> getZoneMomentModels(@RequestParam("uid") String uid) {
        List<MomentModel> momentModels = userService.getZoneMomentModels(uid);
        if (momentModels != null) {
            CommonResponse<List<MomentModel>> commonResponse = CommonResponse.success(momentModels);
            return ResponseEntity.ok(commonResponse);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/getMomentModels")
    public ResponseEntity<CommonResponse<List<MomentModel>>> getMomentModels(@RequestParam("uid") String uid) {
        List<MomentModel> momentModels = userService.getMomentModels(uid);
        if (momentModels != null) {
            CommonResponse<List<MomentModel>> commonResponse = CommonResponse.success(momentModels);
            return ResponseEntity.ok(commonResponse);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/getChatModelList")
    public ResponseEntity<CommonResponse<List<ChatModel>>> getChatModelList(@RequestParam("uid") String uid) {
        List<ChatModel> chatModelList = userService.getChatModelList(uid);
        if (chatModelList != null) {
            CommonResponse<List<ChatModel>> commonResponse = CommonResponse.success(chatModelList);
            return ResponseEntity.ok(commonResponse);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/getChatModel")
    public ResponseEntity<CommonResponse<ChatModel>> getChatModel(@RequestParam("ownerUid") String ownerUid, @RequestParam("friendUid") String friendUid) {
        ChatModel chatModel = userService.getChatModel(ownerUid, friendUid);
        if (chatModel != null) {
            CommonResponse<ChatModel> commonResponse = CommonResponse.success(chatModel);
            return ResponseEntity.ok(commonResponse);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

}