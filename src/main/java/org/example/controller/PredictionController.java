package org.example.controller;

import lombok.RequiredArgsConstructor;
import org.example.dto.GamePredictionResponse;
import org.example.model.GamePrediction;
import org.example.model.TodayGame;
import org.example.repository.GamePredictionRepository;
import org.example.repository.TodayGameRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
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
    @Transactional(readOnly = true)
    public ResponseEntity<List<GamePredictionResponse>> getTodayPredictions() {
        // 모든 오늘의 경기 가져오기
        List<TodayGame> todayGames = todayGameRepository.findAll();
        
        // 각 경기에 대한 예측과 함께 응답 생성
        List<GamePredictionResponse> responses = todayGames.stream()
            .map(game -> {
                // 해당 경기의 예측 찾기
                GamePrediction prediction = gamePredictionRepository.findByTodayGame(game)
                    .orElse(null);
                
                // null 체크
                if (game.getHomeTeam() == null || game.getAwayTeam() == null) {
                    return null;
                }
                
                // 홈팀 로고 경로 변환
                String homeLogo = game.getHomeTeam().getLogo();
                if (homeLogo != null && !homeLogo.isEmpty() && 
                    !homeLogo.startsWith("http://") && !homeLogo.startsWith("https://")) {
                    homeLogo = "/images/" + homeLogo;
                }
                
                // 원정팀 로고 경로 변환
                String awayLogo = game.getAwayTeam().getLogo();
                if (awayLogo != null && !awayLogo.isEmpty() && 
                    !awayLogo.startsWith("http://") && !awayLogo.startsWith("https://")) {
                    awayLogo = "/images/" + awayLogo;
                }
                
                // 홈팀 데이터
                GamePredictionResponse.TeamData homeTeamData = GamePredictionResponse.TeamData.builder()
                    .id(game.getHomeTeam().getId())
                    .name(game.getHomeTeam().getName())
                    .logo(homeLogo)
                    .ops(game.getHomeTeamOps())
                    .era(game.getHomeTeamEra())
                    .build();
                
                // 원정팀 데이터
                GamePredictionResponse.TeamData awayTeamData = GamePredictionResponse.TeamData.builder()
                    .id(game.getAwayTeam().getId())
                    .name(game.getAwayTeam().getName())
                    .logo(awayLogo)
                    .ops(game.getAwayTeamOps())
                    .era(game.getAwayTeamEra())
                    .build();
                
                // 예측된 승자 ID (null 체크 강화)
                Integer predictedWinnerId = null;
                if (prediction != null && prediction.getPredictedWinner() != null) {
                    predictedWinnerId = prediction.getPredictedWinner().getId();
                }
                
                // 응답 생성
                return GamePredictionResponse.builder()
                    .gameId(game.getId())
                    .homeTeam(homeTeamData)
                    .awayTeam(awayTeamData)
                    .predictedWinnerId(predictedWinnerId)
                    .build();
            })
            .filter(response -> response != null) // null 응답 필터링
            .collect(Collectors.toList());
        
        return ResponseEntity.ok(responses);
    }

    @PostMapping("/{todayGameId}")
    public ResponseEntity<GamePrediction> predict(@PathVariable Long todayGameId) {
       return null;
    }
}
