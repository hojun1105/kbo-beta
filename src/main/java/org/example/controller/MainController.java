package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MainController {
    
    @GetMapping("/")
    public String mainPage(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        return "main";
    }

    @GetMapping("/predict")
    public String predictPage(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        return "predict";
    }
}