package model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;


@Entity
@Table(
        name = "hitter_stat",
        schema = "kbo",
        uniqueConstraints = @UniqueConstraint(columnNames = {"player_id", "date"})
)
@Getter
@Setter
@NoArgsConstructor
public class HitterStat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "player_id", nullable = false)
    private PlayerInfo player;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "average")
    private Double average;

    @Column(name = "games")
    private Integer games;

    @Column(name = "plate_appearances")
    private Integer plateAppearances;

    @Column(name = "at_bat")
    private Integer atBat;

    @Column(name = "runs")
    private Integer runs;

    @Column(name = "hits")
    private Integer hits;

    @Column(name = "double_base")
    private Integer doubleBase;

    @Column(name = "triple_base")
    private Integer tripleBase;

    @Column(name = "home_run")
    private Integer homeRun;

    @Column(name = "total_base")
    private Integer totalBase;

    @Column(name = "runs_batted_in")
    private Integer runsBattedIn;

    @Column(name = "stolen_base")
    private Integer stolenBase;

    @Column(name = "caught_stealing")
    private Integer caughtStealing;

    @Column(name = "sacrifice_hit")
    private Integer sacrificeHit;

    @Column(name = "sacrifice_fly")
    private Integer sacrificeFly;

    @Column(name = "based_on_balls")
    private Integer basedOnBalls;

    @Column(name = "intentional_based_on_balls")
    private Integer intentionalBasedOnBalls;

    @Column(name = "hit_by_pitch")
    private Integer hitByPitch;

    @Column(name = "strike_out")
    private Integer strikeOut;

    @Column(name = "grounded_into_double_play")
    private Integer groundedIntoDoublePlay;

    @Column(name = "slugging_percentage")
    private Double sluggingPercentage;

    @Column(name = "on_base_percentage")
    private Double onBasePercentage;

    @Column(name = "error")
    private Integer error;

    @Column(name = "stolen_base_percentage")
    private Double stolenBasePercentage;

    @Column(name = "multi_hit")
    private Integer multiHit;

    @Column(name = "on_base_plus_slugging")
    private Double onBasePlusSlugging;

    @Column(name = "runners_in_scoring_position")
    private Double runnersInScoringPosition;

    @Column(name = "substitute_hitter_batting_average")
    private Double substituteHitterBattingAverage;
}
