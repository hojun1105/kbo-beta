package org.example.dto;

import lombok.Builder;
import lombok.Value;
import org.example.model.TicketGame;

import java.time.LocalDateTime;

public final class TicketGameDto {

    private TicketGameDto() {
    }

    @Value
    @Builder
    public static class Response {
        Long id;
        String homeTeam;
        String awayTeam;
        LocalDateTime gameDate;
        String stadium;
        String stadiumAddress;
        TicketGame.GameStatus status;
        Integer homeScore;
        Integer awayScore;
        String weather;
        String temperature;
        LocalDateTime createdAt;
        LocalDateTime updatedAt;
    }
}




