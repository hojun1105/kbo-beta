package org.example.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.JwtService;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    private final JwtService jwtService;

    public AuthInterceptor(JwtService jwtService) {
        this.jwtService = jwtService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 공개 페이지나 정적 리소스는 통과
        String requestURI = request.getRequestURI();
        if (isPublicPath(requestURI)) {
            return true;
        }

        // JWT 토큰 확인
        String token = extractToken(request);
        
        if (token != null && jwtService.validateToken(token)) {
            // 토큰이 유효하면 사용자 ID를 request에 저장
            String userId = jwtService.extractUserId(token);
            request.setAttribute("userId", userId);
            return true;
        } else {
            // 토큰이 없거나 유효하지 않으면 로그인 페이지로 리다이렉트
            response.sendRedirect("/html/login.html");
            return false;
        }
    }

    private boolean isPublicPath(String requestURI) {
        // 공개적으로 접근 가능한 경로들
        return requestURI.equals("/") ||
               requestURI.contains("/html/login.html") ||
               requestURI.contains("/login") ||
               requestURI.contains("/signup") ||
               requestURI.contains("/html/signup.html") ||
               requestURI.contains("/html/predict.html") ||
               requestURI.contains("/html/playerStat.html") ||
               requestURI.contains("/html/stat.html") ||
               requestURI.contains("/html/stat_detail.html") ||
               requestURI.contains("/images/") ||
               requestURI.contains("/css/") ||
               requestURI.contains("/js/") ||
               requestURI.contains("/error");
    }

    private String extractToken(HttpServletRequest request) {
        // Authorization 헤더에서 토큰 추출
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        
        // 쿠키에서 토큰 추출 (백업)
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
