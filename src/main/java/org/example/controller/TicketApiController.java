package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.dto.TicketGameDto;
import org.example.dto.TicketReservationDto;
import org.example.service.TicketGameService;
import org.example.service.TicketReservationService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/api/ticketing")
@RequiredArgsConstructor
@Slf4j
public class TicketApiController {

    private final TicketGameService ticketGameService;
    private final TicketReservationService ticketReservationService;

    @GetMapping("/games/upcoming")
    public ResponseEntity<List<TicketGameDto.Response>> upcomingGames() {
        return ResponseEntity.ok(ticketGameService.getUpcomingGames());
    }

    @GetMapping("/reservations/my")
    public ResponseEntity<List<TicketReservationDto.Response>> myReservations(HttpServletRequest request) {
        String userId = requireUserId(request);
        return ResponseEntity.ok(ticketReservationService.getByUser(userId));
    }

    @PostMapping("/reservations")
    public ResponseEntity<TicketReservationDto.Response> reserveTicket(
            @RequestBody TicketReservationDto.ReserveRequest requestBody,
            HttpServletRequest request) {
        String userId = requireUserId(request);
        log.info("Ticket reservation request userId={}, body={}", userId, requestBody);
        return ResponseEntity.ok(ticketReservationService.reserve(userId, requestBody));
    }

    @DeleteMapping("/reservations/{reservationId}")
    public ResponseEntity<Void> cancelReservation(@PathVariable Long reservationId,
                                                  HttpServletRequest request) {
        String userId = requireUserId(request);
        ticketReservationService.cancel(reservationId, userId);
        return ResponseEntity.noContent().build();
    }

    private String requireUserId(HttpServletRequest request) {
        Object userId = request.getAttribute("userId");
        if (userId == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다.");
        }
        return userId.toString();
    }
}




