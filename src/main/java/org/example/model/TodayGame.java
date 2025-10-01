package org.example.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;


import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name = "today_games")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TodayGame {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 홈팀
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "home_team_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "fk_todaygame_home_team"))
    private TeamInfo homeTeam;

    @Column(name = "home_team_ops", precision = 5, scale = 3)
    private BigDecimal homeTeamOps;

    @Column(name = "home_team_era", precision = 5, scale = 2)
    private BigDecimal homeTeamEra;

    // 원정팀
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "away_team_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "fk_todaygame_away_team"))
    private TeamInfo awayTeam;

    @Column(name = "away_team_ops", precision = 5, scale = 3)
    private BigDecimal awayTeamOps;

    @Column(name = "away_team_era", precision = 5, scale = 2)
    private BigDecimal awayTeamEra;

    @Column(name = "temperature", precision = 5, scale = 2)
    private BigDecimal temperature;

    @Column(name = "humidity", precision = 5, scale = 2)
    private BigDecimal humidity;
}
