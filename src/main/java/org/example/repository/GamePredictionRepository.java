package org.example.repository;

import org.example.model.GamePrediction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface GamePredictionRepository extends JpaRepository<GamePrediction, Integer> {
}
