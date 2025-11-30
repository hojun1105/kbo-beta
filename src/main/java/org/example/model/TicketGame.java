package org.example.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "ticket_games")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TicketGame {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "home_team", nullable = false)
    private String homeTeam;

    @Column(name = "away_team", nullable = false)
    private String awayTeam;

    @Column(name = "game_date", nullable = false)
    private LocalDateTime gameDate;

    @Column(nullable = false)
    private String stadium;

    @Column(name = "stadium_address")
    private String stadiumAddress;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @Builder.Default
    private GameStatus status = GameStatus.SCHEDULED;

    @Column(name = "home_score")
    private Integer homeScore;

    @Column(name = "away_score")
    private Integer awayScore;

    private String weather;
    private String temperature;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public enum GameStatus {
        SCHEDULED,
        IN_PROGRESS,
        COMPLETED,
        CANCELLED,
        DELAYED
    }
}




