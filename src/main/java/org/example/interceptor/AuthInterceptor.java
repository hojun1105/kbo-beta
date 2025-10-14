package org.example.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.example.service.JwtService;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
@RequiredArgsConstructor
public class AuthInterceptor implements HandlerInterceptor {

    private final JwtService jwtService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestURI = request.getRequestURI();
        String token = extractToken(request);

        // 토큰이 있으면 userId 설정
        if (token != null && jwtService.validateToken(token)) {
            String userId = jwtService.extractUserId(token);
            request.setAttribute("userId", userId);
        }

        // 공개 접근 가능한 경로 (로그인 없이도 접근 가능)
        if (isPublicPath(requestURI)) {
            return true;
        }

        // Protected 경로는 로그인 필요
        if (token != null && jwtService.validateToken(token)) {
            return true;
        } else {
            response.sendRedirect("/login");
            return false;
        }
    }

    private boolean isPublicPath(String requestURI) {
        return requestURI.equals("/") ||
               requestURI.equals("/predict") ||
               requestURI.startsWith("/images/") ||
               requestURI.startsWith("/css/") ||
               requestURI.startsWith("/js/");
    }

    private String extractToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        
        if (request.getCookies() != null) {
            for (var cookie : request.getCookies()) {
                if ("token".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        
        return null;
    }
}
