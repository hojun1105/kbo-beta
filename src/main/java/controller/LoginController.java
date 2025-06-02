package controller;

import jakarta.servlet.http.HttpSession;
import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.UserService;

@Controller
public class LoginController {

    private final UserService userService;

    public LoginController(UserService userService) {
        this.userService = userService;
    }
    @PostMapping("/login")
    public String login(@RequestParam("userId") String userId,
                        @RequestParam("password") String password,
                        HttpSession session) {
        User user = userService.login(userId, password);
        if (user != null) {
            session.setAttribute("userId", user.getUserId());
            return "redirect:/main";
        } else {
            return "redirect:/html/login.html?error=1"; // 실패 시 메시지 전달
        }
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }
}
