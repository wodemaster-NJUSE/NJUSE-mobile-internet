package chat.controller;

import chat.pojo.request.friendRequest.SendMessageRequest;
import chat.pojo.vo.MessageBase;
import chat.service.FriendService;
import io.pojo.CommonResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@CrossOrigin(origins = "http://localhost:5173", allowCredentials = "true")
@RestController
@RequestMapping("/v2/")
@RequiredArgsConstructor
public class FriendController {
    private final FriendService friendService;

    @PostMapping("sendMessage")
    public CommonResponse<?> sendMessage(@Valid @RequestBody SendMessageRequest request) {
        friendService.sendMessage(request.getMessageBase());
        System.out.println("收到发送的消息");
        System.out.println(request.getMessageBase().getMsgId());
        System.out.println(request.getMessageBase().getTo());
        System.out.println(request.getMessageBase().getMsgType());
        System.out.println(request.getMessageBase().getMsgBody());
        System.out.println("结束");
        return CommonResponse.success(200);
    }

    @GetMapping("/getMessages")
    public ResponseEntity<CommonResponse<List<MessageBase>>> getMessages(@RequestParam("ownerUid") String ownerUid, @RequestParam("friendUid") String friendUid) {
        List<MessageBase> messages = friendService.getMessages(ownerUid, friendUid);
        if (messages != null) {
            CommonResponse<List<MessageBase>> commonResponse = CommonResponse.success(messages);
            commonResponse.setCode(200);
            return ResponseEntity.ok(commonResponse);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

