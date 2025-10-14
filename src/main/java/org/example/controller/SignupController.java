package org.example.controller;

import org.example.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.example.service.UserService;

@Controller
public class SignupController {

    private final UserService userService;

    public SignupController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/signup")
    public String showSignupForm() {
        return "signup";
    }

    @PostMapping("/signup")
    public String signup(@RequestParam("nickname") String nickname,
                         @RequestParam("userId") String userId,
                         @RequestParam("password") String password,
                         @RequestParam("email") String email) {
        User user = new User(userId, nickname, password, email, null);
        boolean success = userService.register(user);

        if (success) {
            return "redirect:/login";
        } else {
            return "redirect:/signup?error=1";
        }
    }
}
