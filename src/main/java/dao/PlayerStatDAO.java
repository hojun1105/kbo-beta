package dao;

import model.HitterStat;
import model.PlayerStat;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PlayerStatDAO extends JpaRepository<HitterStat, String> {

    @EntityGraph(attributePaths = {"player","player.team"})
    List<HitterStat> findAllByOrderByDateDesc();
}
