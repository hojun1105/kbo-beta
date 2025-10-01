package org.example.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "game_predictions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GamePrediction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 어떤 경기(today_game)에 대한 예측인지
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "today_game_id", referencedColumnName = "id",
            foreignKey = @ForeignKey(name = "fk_game_predictions_game"))
    private TodayGame todayGame;

    // 예측된 승자
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "predicted_winner", referencedColumnName = "id",
            foreignKey = @ForeignKey(name = "fk_game_predictions_winner"))
    private TeamInfo predictedWinner;
}
