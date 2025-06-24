package com.yourcompany.Config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        // Cấu hình broker cho message (dùng cho subscribe/publish)
        config.enableSimpleBroker("/topic", "/queue"); // Đích cho client subscribe
        config.setApplicationDestinationPrefixes("/app"); // Đích cho client gửi message đến server
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // Đăng ký endpoint cho WebSocket handshake
        registry.addEndpoint("/ws") // Địa chỉ endpoint websocket
                .setAllowedOriginPatterns("*") // Cho phép tất cả các domain (có thể chỉnh lại theo nhu cầu bảo mật)
                .withSockJS(); // Hỗ trợ fallback SockJS cho trình duyệt không hỗ trợ WebSocket
    }
}