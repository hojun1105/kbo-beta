package dao;

import model.PitcherStat;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PitcherStatDAO extends JpaRepository<PitcherStat, String> {

    @EntityGraph(attributePaths = {"player","player.team"})
    List<PitcherStat> findAllByOrderByDateDesc();
}
