package org.example.repository;

import org.example.model.TicketReservation;
import org.example.model.TicketReservation.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TicketReservationRepository extends JpaRepository<TicketReservation, Long> {

    @Query("SELECT t FROM TicketReservation t WHERE t.owner.userId = :userId ORDER BY t.createdAt DESC")
    List<TicketReservation> findByOwner(@Param("userId") String userId);

    @Query("SELECT t FROM TicketReservation t WHERE t.game.id = :gameId ORDER BY t.createdAt DESC")
    List<TicketReservation> findByGame(@Param("gameId") Long gameId);

    List<TicketReservation> findByStatus(ReservationStatus status);
}




