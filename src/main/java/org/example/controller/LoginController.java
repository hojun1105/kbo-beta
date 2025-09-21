package org.example.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.User;
import org.example.service.JwtService;
import org.example.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    private final UserService userService;
    private final JwtService jwtService;

    public LoginController(UserService userService, JwtService jwtService) {
        this.userService = userService;
        this.jwtService = jwtService;
    }

    @PostMapping("/login")
    public String login(@RequestParam("userId") String userId,
                       @RequestParam("password") String password,
                       HttpServletResponse response,
                       Model model) {
        User user = userService.login(userId, password);
        
        if (user != null) {
            // JWT 토큰 생성
            String token = jwtService.generateToken(user.getUserId());
            
            // 쿠키에 토큰 저장
            Cookie tokenCookie = new Cookie("token", token);
            tokenCookie.setHttpOnly(true);
            tokenCookie.setPath("/");
            tokenCookie.setMaxAge(24 * 60 * 60); // 24시간
            response.addCookie(tokenCookie);
            
            // 토큰을 모델에 추가하여 메인 페이지에서 사용할 수 있도록 함
            model.addAttribute("userId", user.getUserId());
            model.addAttribute("isLoggedIn", true);
            
            // 로그인 성공 시 메인 페이지로 포워드
            return "main";
        } else {
            // 로그인 실패 시 에러 메시지와 함께 로그인 페이지로 리다이렉트
            return "redirect:/html/login.html?error=1";
        }
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    @PostMapping("/logout")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> logout(HttpServletResponse response) {
        // 쿠키 삭제
        Cookie tokenCookie = new Cookie("token", "");
        tokenCookie.setHttpOnly(true);
        tokenCookie.setPath("/");
        tokenCookie.setMaxAge(0);
        response.addCookie(tokenCookie);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("message", "로그아웃 성공");
        return ResponseEntity.ok(result);
    }
}
