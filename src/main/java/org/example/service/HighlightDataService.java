package org.example.service;

import org.example.model.GameHighlight;
import org.example.dao.GameHighlightDAO;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class HighlightDataService {
    
    private final GameHighlightDAO gameHighlightDAO;
    
    public HighlightDataService(GameHighlightDAO gameHighlightDAO) {
        this.gameHighlightDAO = gameHighlightDAO;
    }
    
    // 테스트용 하이라이트 데이터 초기화
    public void initializeTestData() {
        // 기존 데이터가 있으면 삭제하고 새로 생성
        if (gameHighlightDAO.count() > 0) {
            gameHighlightDAO.deleteAll();
        }
        
        LocalDate today = LocalDate.now();
        
        // 오늘 경기 하이라이트 데이터
        List<GameHighlight> testHighlights = List.of(
            GameHighlight.builder()
                .gameDate(today)
                .homeTeam("Doosan Bears")
                .awayTeam("SSG Landers")
                .youtubeUrl("https://www.youtube.com/embed/XPEdSrBsV-A")
                .title("두산 vs SSG 하이라이트 - 2025년 1월 15일")
                .description("두산 베어스와 SSG 랜더스의 경기 하이라이트입니다. (두산 3 vs 7 SSG)")
                .thumbnailUrl("https://img.youtube.com/vi/XPEdSrBsV-A/maxresdefault.jpg")
                .duration("10:30")
                .viewCount(15000L)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build(),
                
            GameHighlight.builder()
                .gameDate(today)
                .homeTeam("Samsung Lions")
                .awayTeam("KT Wiz")
                .youtubeUrl("https://www.youtube.com/embed/_Ouq8edwimo")
                .title("삼성 vs KT 하이라이트 - 2025년 1월 15일")
                .description("삼성 라이온즈와 KT 위즈의 경기 하이라이트입니다. (삼성 3 vs 6 KT)")
                .thumbnailUrl("https://img.youtube.com/vi/_Ouq8edwimo/maxresdefault.jpg")
                .duration("8:45")
                .viewCount(12000L)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build(),
                
            GameHighlight.builder()
                .gameDate(today)
                .homeTeam("NC Dinos")
                .awayTeam("KIA Tigers")
                .youtubeUrl("https://www.youtube.com/embed/Xj1oKj66FdU")
                .title("NC vs KIA 하이라이트 - 2025년 1월 15일")
                .description("NC 다이노스와 KIA 타이거즈의 경기 하이라이트입니다. (NC 7 vs 6 KIA)")
                .thumbnailUrl("https://img.youtube.com/vi/Xj1oKj66FdU/maxresdefault.jpg")
                .duration("12:15")
                .viewCount(18000L)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build()
        );
        
        gameHighlightDAO.saveAll(testHighlights);
    }
}
