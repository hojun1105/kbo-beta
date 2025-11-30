package org.example.repository;

import org.example.model.TicketGame;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface TicketGameRepository extends JpaRepository<TicketGame, Long> {

    @Query("SELECT g FROM TicketGame g WHERE g.gameDate >= :startDate AND g.gameDate <= :endDate ORDER BY g.gameDate ASC")
    List<TicketGame> findGamesByDateRange(@Param("startDate") LocalDateTime startDate,
                                          @Param("endDate") LocalDateTime endDate);

    @Query("SELECT g FROM TicketGame g WHERE g.homeTeam = :team OR g.awayTeam = :team ORDER BY g.gameDate ASC")
    List<TicketGame> findGamesByTeam(@Param("team") String team);

    @Query("SELECT g FROM TicketGame g WHERE g.stadium = :stadium ORDER BY g.gameDate ASC")
    List<TicketGame> findGamesByStadium(@Param("stadium") String stadium);

    @Query("SELECT g FROM TicketGame g WHERE g.status = :status ORDER BY g.gameDate ASC")
    List<TicketGame> findGamesByStatus(@Param("status") TicketGame.GameStatus status);

    @Query("SELECT g FROM TicketGame g WHERE g.gameDate >= :now ORDER BY g.gameDate ASC")
    List<TicketGame> findUpcomingGames(@Param("now") LocalDateTime now);

    @Query("SELECT DISTINCT g.homeTeam FROM TicketGame g ORDER BY g.homeTeam")
    List<String> findAllTeams();

    @Query("SELECT DISTINCT g.stadium FROM TicketGame g ORDER BY g.stadium")
    List<String> findAllStadiums();
}




