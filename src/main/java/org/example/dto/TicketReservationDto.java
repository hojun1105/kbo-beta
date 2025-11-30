package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Value;
import org.example.model.TicketReservation;

import java.time.LocalDateTime;

public final class TicketReservationDto {

    private TicketReservationDto() {
    }

    @Value
    @Builder
    public static class Response {
        Long id;
        String ownerId;
        String ownerNickname;
        Long gameId;
        String homeTeam;
        String awayTeam;
        LocalDateTime gameDate;
        String stadium;
        String seatSection;
        String seatRow;
        String seatNumber;
        TicketReservation.ReservationStatus status;
        String description;
        LocalDateTime createdAt;
        LocalDateTime updatedAt;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ReserveRequest {
        private Long gameId;
        private String seatSection;
        private String seatRow;
        private String seatNumber;
        private String description;
    }
}




