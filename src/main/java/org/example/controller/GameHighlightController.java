package org.example.controller;

import org.example.model.GameHighlight;
import org.example.service.GameHighlightService;
import org.example.service.JwtService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class GameHighlightController {
    
    private final GameHighlightService gameHighlightService;
    private final JwtService jwtService;
    
    public GameHighlightController(GameHighlightService gameHighlightService, JwtService jwtService) {
        this.gameHighlightService = gameHighlightService;
        this.jwtService = jwtService;
    }
    
    @GetMapping("/highlights")
    public String showHighlights(Model model, @RequestParam(required = false) String team, HttpServletRequest request) {
        List<GameHighlight> highlights;
        
        if (team != null && !team.isEmpty()) {
            highlights = gameHighlightService.getTodayHighlightsByTeam(team);
            model.addAttribute("selectedTeam", team);
        } else {
            highlights = gameHighlightService.getTodayHighlights();
        }
        
        String token = extractToken(request);
        String userId = null;
        boolean isLoggedIn = false;
        
        if (token != null && jwtService.validateToken(token)) {
            userId = jwtService.extractUserId(token);
            isLoggedIn = true;
        }
        
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", isLoggedIn);
        model.addAttribute("highlights", highlights);
        model.addAttribute("teams", getKboTeams());
        
        return "highlights";
    }
    
    private String[] getKboTeams() {
        return new String[]{
            "Doosan Bears", "LG Twins", "Kiwoom Heroes", "SSG Landers", 
            "Hanwha Eagles", "NC Dinos", "Lotte Giants", "Samsung Lions", 
            "KIA Tigers", "KT Wiz"
        };
    }
    
    private String extractToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        
        if (request.getCookies() != null) {
            for (var cookie : request.getCookies()) {
                if ("token".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        
        return null;
    }
}
