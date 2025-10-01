package org.example.repository;

import org.example.model.GamePrediction;
import org.example.model.TodayGame;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GamePredictionRepository extends JpaRepository<GamePrediction, Integer> {
    Optional<GamePrediction> findByTodayGame(TodayGame todayGame);
}
