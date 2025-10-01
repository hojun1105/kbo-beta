package org.example.repository;

import org.example.model.TodayGame;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TodayGameRepository extends JpaRepository<TodayGame,Long> {
}
