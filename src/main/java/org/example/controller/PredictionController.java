package org.example.controller;

import lombok.RequiredArgsConstructor;
import org.example.model.GamePrediction;
import org.example.model.TodayGame;
import org.example.repository.GamePredictionRepository;
import org.example.repository.TeamInfoRepository;
import org.example.repository.TodayGameRepository;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController("/prediction")
@RequiredArgsConstructor
public class PredictionController {

    private final TodayGameRepository todayGameRepository;
    private final GamePredictionRepository gamePredictionRepository;
    private final TeamInfoRepository teamInfoRepository;

    @PostMapping("/{todayGameId}")
    public ResponseEntity<GamePrediction> predict(@PathVariable Long todayGameId) {
       return null;}
}
