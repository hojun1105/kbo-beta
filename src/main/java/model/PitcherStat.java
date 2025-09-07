package model;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "pitcher_stat_1",
        schema = "kbo",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"player_id", "\"date\""})
        }
)
public class PitcherStat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // BIGSERIAL
    private Long id;

    // FK: player_info(id)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "player_id", nullable = false)
    private PlayerInfo player;

    @Column(name = "\"date\"", nullable = false)  // 따옴표 컬럼
    private LocalDate date;

    @Column(name = "rank")
    private Integer rank;

    @Column(name = "era")
    private BigDecimal era;  // NUMERIC(5,2)

    @Column(name = "games")
    private Integer games;

    @Column(name = "wins")
    private Integer wins;

    @Column(name = "losses")
    private Integer losses;

    @Column(name = "saves")
    private Integer saves;

    @Column(name = "holds")
    private Integer holds;

    @Column(name = "winning_percentage")
    private BigDecimal winningPercentage;  // NUMERIC(5,3)

    @Column(name = "innings_pitched")
    private BigDecimal inningsPitched;     // NUMERIC(6,3)

    @Column(name = "hits")
    private Integer hits;

    @Column(name = "home_runs")
    private Integer homeRuns;

    @Column(name = "walks")
    private Integer walks;

    @Column(name = "hit_by_pitch")
    private Integer hitByPitch;

    @Column(name = "strike_outs")
    private Integer strikeOuts;

    @Column(name = "runs")
    private Integer runs;

    @Column(name = "earned_runs")
    private Integer earnedRuns;

    @Column(name = "whip")
    private BigDecimal whip;               // NUMERIC(6,3)
}

