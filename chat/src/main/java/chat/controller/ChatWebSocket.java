/*
package chat.controller;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.websocket.*;
import javax.websocket.server.*;
import java.io.IOException;

@Component
@ServerEndpoint(value = "/websocket/1") //暴露的ws应用的路径
public class ChatWebSocket {

    */
/**
     * 客户端与服务端连接成功
     * @param session
     * @param username
     *//*

    @OnOpen
    public void onOpen(Session session,@PathParam("username") String username){
        System.err.println("WebSocket 连接成功");
    }

    */
/**
     * 客户端与服务端连接关闭
     * @param session
     * @param username
     *//*

    @OnClose
    public void onClose(Session session,@PathParam("username") String username){
        */
/*
            do something for onClose
            与当前客户端连接关闭时
         *//*

    }

    */
/**
     * 客户端与服务端连接异常
     * @param error
     * @param session
     * @param username
     *//*

    @OnError
    public void onError(Throwable error,Session session,@PathParam("username") String username) {
    }

    */
/**
     * 客户端向服务端发送消息
     * @param message
     * @param username
     * @throws IOException
     *//*

    @OnMessage
    public void onMsg(Session session,String message,@PathParam("username") String username) throws IOException {
        System.err.println("接收到前端会话");
    }
}*/
