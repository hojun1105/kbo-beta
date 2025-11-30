package org.example.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.dao.UserDAO;
import org.example.dto.TicketReservationDto;
import org.example.model.TicketReservation;
import org.example.repository.TicketGameRepository;
import org.example.repository.TicketReservationRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class TicketReservationService {

    private final TicketReservationRepository ticketReservationRepository;
    private final TicketGameRepository ticketGameRepository;
    private final UserDAO userDAO;

    @Transactional
    public TicketReservationDto.Response reserve(String userId, TicketReservationDto.ReserveRequest request) {
        var user = userDAO.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다. id=" + userId));

        var game = ticketGameRepository.findById(request.getGameId())
                .orElseThrow(() -> new IllegalArgumentException("경기를 찾을 수 없습니다. id=" + request.getGameId()));

        TicketReservation reservation = TicketReservation.builder()
                .owner(user)
                .game(game)
                .seatSection(request.getSeatSection())
                .seatRow(request.getSeatRow())
                .seatNumber(request.getSeatNumber())
                .description(request.getDescription())
                .status(TicketReservation.ReservationStatus.RESERVED)
                .build();

        TicketReservation saved = ticketReservationRepository.save(reservation);
        log.info("티켓 예약 완료 userId={}, gameId={}, reservationId={}", userId, request.getGameId(), saved.getId());
        return toResponse(saved);
    }

    @Transactional(readOnly = true)
    public List<TicketReservationDto.Response> getByUser(String userId) {
        return ticketReservationRepository.findByOwner(userId)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<TicketReservationDto.Response> getByGame(Long gameId) {
        return ticketReservationRepository.findByGame(gameId)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<TicketReservationDto.Response> getAll() {
        return ticketReservationRepository.findAll()
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    public void cancel(Long reservationId, String userId) {
        TicketReservation reservation = ticketReservationRepository.findById(reservationId)
                .orElseThrow(() -> new IllegalArgumentException("티켓을 찾을 수 없습니다. id=" + reservationId));

        if (!reservation.getOwner().getUserId().equals(userId)) {
            throw new IllegalStateException("본인의 티켓만 취소할 수 있습니다.");
        }

        reservation.setStatus(TicketReservation.ReservationStatus.CANCELLED);
        log.info("티켓 예약 취소 reservationId={}, userId={}", reservationId, userId);
    }

    private TicketReservationDto.Response toResponse(TicketReservation reservation) {
        return TicketReservationDto.Response.builder()
                .id(reservation.getId())
                .ownerId(reservation.getOwner().getUserId())
                .ownerNickname(reservation.getOwner().getNickname())
                .gameId(reservation.getGame().getId())
                .homeTeam(reservation.getGame().getHomeTeam())
                .awayTeam(reservation.getGame().getAwayTeam())
                .gameDate(reservation.getGame().getGameDate())
                .stadium(reservation.getGame().getStadium())
                .seatSection(reservation.getSeatSection())
                .seatRow(reservation.getSeatRow())
                .seatNumber(reservation.getSeatNumber())
                .status(reservation.getStatus())
                .description(reservation.getDescription())
                .createdAt(reservation.getCreatedAt())
                .updatedAt(reservation.getUpdatedAt())
                .build();
    }
}




