package org.example.service;

import org.example.dao.GameHighlightDAO;
import org.example.model.GameHighlight;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class GameHighlightService {
    
    private final GameHighlightDAO gameHighlightDAO;
    
    public GameHighlightService(GameHighlightDAO gameHighlightDAO) {
        this.gameHighlightDAO = gameHighlightDAO;
    }
    
    // 오늘 경기 하이라이트 조회
    public List<GameHighlight> getTodayHighlights() {
        return gameHighlightDAO.findByGameDateOrderByCreatedAtDesc(LocalDate.now());
    }
    
    // 특정 팀의 오늘 하이라이트 조회
    public List<GameHighlight> getTodayHighlightsByTeam(String team) {
        return gameHighlightDAO.findByGameDateAndTeamOrderByCreatedAtDesc(LocalDate.now(), team);
    }
    
    // 최근 하이라이트 조회 (최근 7일)
    public List<GameHighlight> getRecentHighlights() {
        LocalDate weekAgo = LocalDate.now().minusDays(7);
        return gameHighlightDAO.findRecentHighlights(weekAgo);
    }
    
    // 하이라이트 저장
    public GameHighlight saveHighlight(GameHighlight highlight) {
        return gameHighlightDAO.save(highlight);
    }
    
    // 하이라이트 삭제
    public void deleteHighlight(Long id) {
        gameHighlightDAO.deleteById(id);
    }
    
    // 모든 하이라이트 조회
    public List<GameHighlight> getAllHighlights() {
        return gameHighlightDAO.findAll();
    }
}

