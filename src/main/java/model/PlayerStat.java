package model;

public record PlayerStat(
        String year,
        String team,
        double avg,
        int games,
        int pa,
        int ab,
        int runs,
        int hits,
        int doubles,
        int triples,
        int homeruns,
        int tb,
        int rbi,
        int sb,
        int cs,
        int bb,
        int so,
        double slg,
        double obp
) {}
