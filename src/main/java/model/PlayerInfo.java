package model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(
        name = "player_info",
        schema = "kbo",
        uniqueConstraints = @UniqueConstraint(columnNames = {"name", "team_id"})
)
@Getter
@Setter
@NoArgsConstructor
public class PlayerInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false, length = 50)
    private String name;

    @Column(name = "position", length = 10)
    private String position;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "team_id", nullable = false)
    private TeamInfo team;

    @Column(name = "back_number")
    private Integer backNumber;

    @Column(name = "birth_date")
    private LocalDate birthDate;

    @Column(name = "height_weight")
    private String heightWeight;

    @Column(name = "salary")
    private Long salary;

    @Column(name = "debut_year")
    private Integer debutYear;

    @OneToMany(mappedBy = "player", cascade = CascadeType.ALL)
    private List<HitterStat> hitterStats = new ArrayList<>();
}