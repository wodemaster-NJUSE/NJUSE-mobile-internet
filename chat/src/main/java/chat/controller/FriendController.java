package chat.controller;

import chat.pojo.object.Text;
import chat.pojo.request.friendRequest.GetMessagesRequest;
import chat.pojo.request.friendRequest.SendMessageRequest;
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
        return CommonResponse.success(200);
    }

    @GetMapping("/getMessages")
    public ResponseEntity<CommonResponse<List<Text>>> getMessages(@RequestParam("ownerUid") String ownerUid, @RequestParam("friendUid") String friendUid) {
        List<Text> messages = friendService.getMessages(ownerUid, friendUid);
        if (messages != null) {
            CommonResponse<List<Text>> commonResponse = CommonResponse.success(messages);
            return ResponseEntity.ok(commonResponse);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

