package model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(
        name = "pitcher_stat",
        schema = "kbo",
        uniqueConstraints = @UniqueConstraint(columnNames = {"player_id", "date"})
)
@Getter
@Setter
@NoArgsConstructor
public class PitcherStat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "player_id", nullable = false)
    private PlayerInfo player;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "era")
    private Double era;

    @Column(name = "games")
    private Integer games;

    @Column(name = "wins")
    private Integer wins;

    @Column(name = "losses")
    private Integer losses;

    @Column(name = "saves")
    private Integer saves;

    @Column(name = "innings_pitched")
    private Double inningsPitched;

    @Column(name = "strike_outs")
    private Integer strikeOuts;

    @Column(name = "walks")
    private Integer walks;

    @Column(name = "hits_allowed")
    private Integer hitsAllowed;

    @Column(name = "runs_allowed")
    private Integer runsAllowed;

    @Column(name = "earned_runs")
    private Integer earnedRuns;

    @Column(name = "home_runs_allowed")
    private Integer homeRunsAllowed;

    @Column(name = "hit_by_pitch")
    private Integer hitByPitch;

    @Column(name = "wild_pitches")
    private Integer wildPitches;

    @Column(name = "balks")
    private Integer balks;

    @Column(name = "complete_games")
    private Integer completeGames;

    @Column(name = "shutouts")
    private Integer shutouts;

    @Column(name = "quality_starts")
    private Integer qualityStarts;

    @Column(name = "holds")
    private Integer holds;

    @Column(name = "blown_saves")
    private Integer blownSaves;

    @Column(name = "whip")
    private Double whip;

    @Column(name = "batting_average_against")
    private Double battingAverageAgainst;

    @Column(name = "strikeout_per_nine")
    private Double strikeoutPerNine;

    @Column(name = "walk_per_nine")
    private Double walkPerNine;

    @Column(name = "home_run_per_nine")
    private Double homeRunPerNine;

    @Column(name = "strikeout_to_walk_ratio")
    private Double strikeoutToWalkRatio;

    @Column(name = "pitches_thrown")
    private Integer pitchesThrown;

    @Column(name = "strikes")
    private Integer strikes;

    @Column(name = "balls")
    private Integer balls;

    @Column(name = "first_pitch_strikes")
    private Integer firstPitchStrikes;

    @Column(name = "strike_percentage")
    private Double strikePercentage;

    @Column(name = "first_pitch_strike_percentage")
    private Double firstPitchStrikePercentage;
}
