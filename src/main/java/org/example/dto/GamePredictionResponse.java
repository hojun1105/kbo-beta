package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GamePredictionResponse {
    private Long gameId;
    private TeamData homeTeam;
    private TeamData awayTeam;
    private Integer predictedWinnerId;
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TeamData {
        private Integer id;
        private String name;
        private BigDecimal ops;
        private BigDecimal era;
    }
}

