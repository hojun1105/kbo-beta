package org.example.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "game_highlights")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GameHighlight {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "game_date", nullable = false)
    private LocalDate gameDate;
    
    @Column(name = "home_team", nullable = false, length = 50)
    private String homeTeam;
    
    @Column(name = "away_team", nullable = false, length = 50)
    private String awayTeam;
    
    @Column(name = "youtube_url", nullable = false, length = 500)
    private String youtubeUrl;
    
    @Column(name = "title", length = 200)
    private String title;
    
    @Column(name = "description", length = 1000)
    private String description;
    
    @Column(name = "thumbnail_url", length = 500)
    private String thumbnailUrl;
    
    @Column(name = "duration", length = 20)
    private String duration;
    
    @Column(name = "view_count")
    private Long viewCount;
    
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
}

