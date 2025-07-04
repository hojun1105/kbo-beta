package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    @GetMapping("/")
    public String mainPage() {
        return "main"; // → "/WEB-INF/views/main.jsp" 로 포워딩됨
    }
}