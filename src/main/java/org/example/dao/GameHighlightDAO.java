package org.example.dao;

import org.example.model.GameHighlight;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface GameHighlightDAO extends JpaRepository<GameHighlight, Long> {
    
    // 오늘 경기 하이라이트 조회
    @Query("SELECT h FROM GameHighlight h WHERE h.gameDate = :date ORDER BY h.createdAt DESC")
    List<GameHighlight> findByGameDateOrderByCreatedAtDesc(@Param("date") LocalDate date);
    
    // 특정 팀의 하이라이트 조회
    @Query("SELECT h FROM GameHighlight h WHERE h.gameDate = :date AND (h.homeTeam = :team OR h.awayTeam = :team) ORDER BY h.createdAt DESC")
    List<GameHighlight> findByGameDateAndTeamOrderByCreatedAtDesc(@Param("date") LocalDate date, @Param("team") String team);
    
    // 최근 하이라이트 조회 (최근 7일)
    @Query("SELECT h FROM GameHighlight h WHERE h.gameDate >= :startDate ORDER BY h.gameDate DESC, h.createdAt DESC")
    List<GameHighlight> findRecentHighlights(@Param("startDate") LocalDate startDate);
}

