package org.example.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.dto.TicketGameDto;
import org.example.model.TicketGame;
import org.example.repository.TicketGameRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class TicketGameService {

    private final TicketGameRepository ticketGameRepository;

    @Transactional(readOnly = true)
    public List<TicketGameDto.Response> getUpcomingGames() {
        List<TicketGame> games = ticketGameRepository.findUpcomingGames(LocalDateTime.now());
        return games.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public TicketGameDto.Response getGame(Long id) {
        TicketGame game = ticketGameRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("경기를 찾을 수 없습니다. id=" + id));
        return toResponse(game);
    }

    private TicketGameDto.Response toResponse(TicketGame game) {
        return TicketGameDto.Response.builder()
                .id(game.getId())
                .homeTeam(game.getHomeTeam())
                .awayTeam(game.getAwayTeam())
                .gameDate(game.getGameDate())
                .stadium(game.getStadium())
                .stadiumAddress(game.getStadiumAddress())
                .status(game.getStatus())
                .homeScore(game.getHomeScore())
                .awayScore(game.getAwayScore())
                .weather(game.getWeather())
                .temperature(game.getTemperature())
                .createdAt(game.getCreatedAt())
                .updatedAt(game.getUpdatedAt())
                .build();
    }
}




