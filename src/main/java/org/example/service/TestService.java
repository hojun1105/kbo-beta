package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.model.TeamInfo;
import org.example.repository.TeamInfoRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component
@RequiredArgsConstructor
public class TestService implements CommandLineRunner {
    private final TeamInfoRepository teamInfoRepository;

    @Override
    public void run(String... args) throws Exception {

        if(teamInfoRepository.count() == 0){
            String[][] teams = {
                    {"LG Twins", "lg.jpg"},
                    {"Doosan Bears", "doosan.jpg"},
                    {"SSG Landers", "ssg.jpg"},
                    {"Kiwoom Heroes", "kiwoom.jpg"},
                    {"Lotte Giants", "lotte.jpg"},
                    {"Hanwha Eagles", "hanwha.jpg"},
                    {"Samsung Lions", "samsung.jpg"},
                    {"KIA Tigers", "kia.jpg"},
                    {"NC Dinos", "nc.jpg"},
                    {"KT Wiz", "kt.jpg"}
            };

            Arrays.stream(teams).forEach(t -> {
                TeamInfo team = TeamInfo.builder()
                        .name(t[0]).logo(t[1]).build();
                teamInfoRepository.save(team);
            });
        }
    }
}
