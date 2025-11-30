package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.model.TeamInfo;
import org.example.model.TicketGame;
import org.example.repository.TeamInfoRepository;
import org.example.repository.TicketGameRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Component
@RequiredArgsConstructor
public class TestService implements CommandLineRunner {

    private final TeamInfoRepository teamInfoRepository;
    private final TicketGameRepository ticketGameRepository;

    @Override
    public void run(String... args) {
        seedTeams();
        seedTicketGames();
    }

    private void seedTeams() {
        if (teamInfoRepository.count() > 0) {
            return;
        }

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
                    .name(t[0])
                    .logo(t[1])
                    .build();
            teamInfoRepository.save(team);
        });
    }

    private void seedTicketGames() {
        if (ticketGameRepository.count() > 0) {
            return;
        }

        LocalDateTime base = LocalDateTime.now().withHour(18).withMinute(30).withSecond(0).withNano(0);
        List<TicketGame> games = List.of(
                TicketGame.builder()
                        .homeTeam("LG 트윈스")
                        .awayTeam("두산 베어스")
                        .gameDate(base.plusDays(3))
                        .stadium("잠실야구장")
                        .stadiumAddress("서울특별시 송파구 올림픽로 25")
                        .weather("맑음")
                        .temperature("23°C")
                        .build(),
                TicketGame.builder()
                        .homeTeam("한화 이글스")
                        .awayTeam("KIA 타이거즈")
                        .gameDate(base.plusDays(5))
                        .stadium("한화생명 이글스파크")
                        .stadiumAddress("대전광역시 중구 대종로 373")
                        .weather("구름 많음")
                        .temperature("21°C")
                        .build(),
                TicketGame.builder()
                        .homeTeam("롯데 자이언츠")
                        .awayTeam("SSG 랜더스")
                        .gameDate(base.plusDays(7))
                        .stadium("사직야구장")
                        .stadiumAddress("부산광역시 동래구 사직로 45")
                        .weather("흐림")
                        .temperature("20°C")
                        .build(),
                TicketGame.builder()
                        .homeTeam("삼성 라이온즈")
                        .awayTeam("NC 다이노스")
                        .gameDate(base.plusDays(9))
                        .stadium("대구 삼성 라이온즈 파크")
                        .stadiumAddress("대구광역시 수성구 야구전설로 1")
                        .weather("맑음")
                        .temperature("24°C")
                        .build()
        );

        ticketGameRepository.saveAll(games);
    }
}
