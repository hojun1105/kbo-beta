package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.example.service.UserService;

@Controller
public class UserInfoController {
    private final UserService userService;

    public UserInfoController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/userInfo")
    public String getUserInfo(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        if (userId == null) {
            return "redirect:/html/login.html";
        }

        User user = userService.getUserById(userId);
        if (user == null) {
            model.addAttribute("error", "회원 정보를 불러오지 못했습니다.");
            return "errorPage";
        }

        model.addAttribute("user", user);
        return "myinfo";
    }

    @PostMapping("/updateUser")
    public String updateUser(User userForm, HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        if (userId == null) {
            return "redirect:/html/login.html";
        }

        userService.updateUserInfo(userId, userForm);
        return "myinfo";
    }

    @GetMapping("/deleteUser")
    public String deleteUser(HttpServletRequest request, HttpServletResponse response) {
        String userId = (String) request.getAttribute("userId");

        if (userId == null) {
            return "redirect:/html/login.html";
        }
        
        userService.deleteUserById(userId);
        
        // 쿠키 삭제
        response.addCookie(new jakarta.servlet.http.Cookie("token", ""));
        
        return "redirect:/";
    }
}
