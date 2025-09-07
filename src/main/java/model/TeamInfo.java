package model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "team_info", schema = "kbo")
@Getter
@Setter
@NoArgsConstructor
public class TeamInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false, length = 50)
    private String name;

    @Column(name = "logo")
    private String logo;

    @OneToMany(mappedBy = "team")
    private List<PlayerInfo> players;
}