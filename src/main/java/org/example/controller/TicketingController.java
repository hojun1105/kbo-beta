package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.example.service.TicketGameService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class TicketingController {

    private final TicketGameService ticketGameService;

    @GetMapping("/ticketing")
    public String viewTicketing(Model model, HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("activePage", "ticketing");
        model.addAttribute("upcomingGames", ticketGameService.getUpcomingGames());
        model.addAttribute("currentUserId", userId);
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        return "ticketing";
    }

    @GetMapping("/ticketing/reserve")
    public String viewReservation(@RequestParam("gameId") Long gameId,
                                  Model model,
                                  HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("activePage", "ticketing");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        model.addAttribute("game", ticketGameService.getGame(gameId));
        return "ticketing_reserve";
    }
}
