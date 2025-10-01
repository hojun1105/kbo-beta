package org.example.controller;

import lombok.RequiredArgsConstructor;
import org.example.dto.GamePredictionResponse;
import org.example.model.GamePrediction;
import org.example.model.TodayGame;
import org.example.repository.GamePredictionRepository;
import org.example.repository.TodayGameRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/prediction")
@RequiredArgsConstructor
public class PredictionController {

    private final TodayGameRepository todayGameRepository;
    private final GamePredictionRepository gamePredictionRepository;

    @GetMapping("/today")
    public ResponseEntity<List<GamePredictionResponse>> getTodayPredictions() {
        // 모든 오늘의 경기 가져오기
        List<TodayGame> todayGames = todayGameRepository.findAll();
        
        // 각 경기에 대한 예측과 함께 응답 생성
        List<GamePredictionResponse> responses = todayGames.stream()
            .map(game -> {
                // 해당 경기의 예측 찾기
                GamePrediction prediction = gamePredictionRepository.findByTodayGame(game)
                    .orElse(null);
                
                // 홈팀 데이터
                GamePredictionResponse.TeamData homeTeamData = GamePredictionResponse.TeamData.builder()
                    .id(game.getHomeTeam().getId())
                    .name(game.getHomeTeam().getName())
                    .ops(game.getHomeTeamOps())
                    .era(game.getHomeTeamEra())
                    .build();
                
                // 원정팀 데이터
                GamePredictionResponse.TeamData awayTeamData = GamePredictionResponse.TeamData.builder()
                    .id(game.getAwayTeam().getId())
                    .name(game.getAwayTeam().getName())
                    .ops(game.getAwayTeamOps())
                    .era(game.getAwayTeamEra())
                    .build();
                
                // 응답 생성
                return GamePredictionResponse.builder()
                    .gameId(game.getId())
                    .homeTeam(homeTeamData)
                    .awayTeam(awayTeamData)
                    .predictedWinnerId(prediction != null ? prediction.getPredictedWinner().getId() : null)
                    .build();
            })
            .collect(Collectors.toList());
        
        return ResponseEntity.ok(responses);
    }

    @PostMapping("/{todayGameId}")
    public ResponseEntity<GamePrediction> predict(@PathVariable Long todayGameId) {
       return null;
    }
}
