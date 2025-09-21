package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MainController {
    @GetMapping("/")
    public String mainPage(HttpServletRequest request, Model model) {
        // 인터셉터에서 설정한 userId 가져오기
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        return "main"; // → "/WEB-INF/views/main.jsp" 로 포워딩됨
    }

    @GetMapping("/html/predict.html")
    public String predictPage(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        return "predict";
    }

    @GetMapping("/html/playerStat.html")
    public String playerStatPage(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        return "playerStat";
    }

    @GetMapping("/html/stat.html")
    public String statPage(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        return "stat";
    }

    @GetMapping("/html/stat_detail.html")
    public String statDetailPage(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        return "stat_detail";
    }
}