package chat.service.impl;

import chat.dao.FriendDao;
import chat.pojo.entity.FriendEntity;
import chat.pojo.object.ChatMessage;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ChatWebSocketHandlerImpl implements WebSocketHandler {
    // Json 转 JavaObject
    private static final Gson gson = new Gson();

    // session 池, key: senderUid， value: WebSocketSession
    // 即当前在线用户
    private static final Map<String, WebSocketSession> sessionPool = new HashMap<>();

    // 访问数据库
    private final FriendDao friendDao;

    @Override
    public void afterConnectionEstablished(@NotNull WebSocketSession webSocketSession) throws Exception {
        System.err.print("ChatWebSocketHandlerImpl.afterConnectionEstablished(): ");
        System.err.println("连接已建立: " + webSocketSession);

        // 连接建立，转发所有旧消息

        // sessionPool.put()
    }

    @Override
    public void handleMessage(@NotNull WebSocketSession webSocketSession, @NotNull WebSocketMessage<?> webSocketMessage) throws Exception {
        ChatMessage chatMessage = gson.fromJson(webSocketMessage.getPayload().toString(), ChatMessage.class);

        System.err.print("ChatWebSocketHandlerImpl.handleMessage(): ");
        // System.err.println("收到信息: " + webSocketMessage);
        System.err.println("payload: " + webSocketMessage.getPayload());
        // System.err.print("ChatWebSocketHandlerImpl.handleMessage(): ");
        // System.err.println("将 Json 串转化为 Java 对象：" + chatMessage);

        String senderUid = chatMessage.getSenderUid();
        String receiverUid = chatMessage.getReceiverUid();

        // 发送者持有接受者的朋友关系， 接受者也持有发送者的朋友关系
        // 双方都要进行数据库存储
        FriendEntity senderOwnReceiver = friendDao.findByOwnerUidAndFriendUid(senderUid, receiverUid);
        FriendEntity receiverOwnSender = friendDao.findByOwnerUidAndFriendUid(receiverUid, senderUid);
        senderOwnReceiver.getMessages().add(chatMessage);
        receiverOwnSender.getMessages().add(chatMessage);
    }

    @Override
    public void handleTransportError(@NotNull WebSocketSession webSocketSession, @NotNull Throwable throwable) throws Exception {

    }

    @Override
    public void afterConnectionClosed(@NotNull WebSocketSession webSocketSession, @NotNull CloseStatus closeStatus) throws Exception {
        System.err.print("ChatWebSocketHandlerImpl: ");
        System.err.println("连接已关闭: " + webSocketSession);

        // sessionPool.remove(webSocketSession.getUri().)
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }
}
