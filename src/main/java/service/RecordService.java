package service;

import dao.PlayerStatDAO;
import dao.PitcherStatDAO;
import model.HitterStat;
import model.PitcherStat;
import model.PlayerStat;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecordService {

    private final PlayerStatDAO recordDAO;
    private final PitcherStatDAO pitcherStatDAO;

    public RecordService(PlayerStatDAO recordDAO, PitcherStatDAO pitcherStatDAO) {
        this.recordDAO = recordDAO;
        this.pitcherStatDAO = pitcherStatDAO;
    }

    public List<HitterStat> getAllRecords() {
        return recordDAO.findAllByOrderByDateDesc();
    }

    public List<PitcherStat> getAllPitcherRecords() {
        return pitcherStatDAO.findAllByOrderByDateDesc();
    }
}
