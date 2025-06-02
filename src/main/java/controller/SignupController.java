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
    public String signup(@RequestParam("userId") String userId,
                         @RequestParam("password") String password,
                         @RequestParam("email") String email) {

        User user = new User(userId, password, email);
        boolean success = userService.register(user);

        if (success) {
            return "redirect:/login";
        } else {
            return "signup"; // 다시 회원가입 화면
        }
    }
}
