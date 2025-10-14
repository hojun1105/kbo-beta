package org.example.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.example.model.User;
import org.example.service.JwtService;
import org.example.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final UserService userService;
    private final JwtService jwtService;

    @PostMapping("/login")
    public String login(@RequestParam("userId") String userId,
                       @RequestParam("password") String password,
                       HttpServletResponse response) {
        User user = userService.login(userId, password);

        if(user == null){
            return "redirect:/login?error=1";
        }
        
        String token = jwtService.generateToken(user.getUserId());

        Cookie tokenCookie = new Cookie("token", token);
        tokenCookie.setHttpOnly(true);
        tokenCookie.setPath("/");
        tokenCookie.setMaxAge(24 * 60 * 60);
        response.addCookie(tokenCookie);

        return "redirect:/";
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }
}
