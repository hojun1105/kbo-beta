package controller;

import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import service.UserService;

@Controller
public class SignupController {

    private final UserService userService;

    @Autowired
    public SignupController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/signup")
    public String showSignupForm() {
        return "signup"; // → /WEB-INF/views/signup.jsp
    }

    @PostMapping("/signup")
    public String signup(@RequestParam("nickname") String nickname,
                         @RequestParam("userId") String userId,
                         @RequestParam("password") String password,
                         @RequestParam("email") String email) {

        User user = new User(userId, nickname, password, email,null);
        boolean success = userService.register(user);

        if (success) {
            return "redirect:/html/login.html";
        } else {
            return "redirect:/html/signup.html?error=1"; // 실패 시 메시지 전달
        }
    }

}
