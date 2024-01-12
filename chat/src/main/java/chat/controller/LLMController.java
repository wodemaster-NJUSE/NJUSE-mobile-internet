package chat.controller;

import chat.pojo.request.messageReq;
import chat.service.impl.LLMImpl;
import io.pojo.CommonResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@CrossOrigin(origins = "http://localhost:5173", allowCredentials = "true")
@RestController
@RequestMapping("/LLM/")
@RequiredArgsConstructor
public class LLMController {

    @PostMapping("send")
    public CommonResponse<String> findByUid(@Valid @RequestBody messageReq request) throws Exception {
        CommonResponse<String> commonResponse = new CommonResponse<>();
        String answer = LLMImpl.getLLMResponse(request.getUID(), request.getQuestion());
        commonResponse.setData(answer);
        commonResponse.setCode(200);

        return commonResponse;
    }
}

