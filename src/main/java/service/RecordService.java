package service;

import dao.PlayerStatDAO;
import model.HitterStat;
import model.PlayerStat;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecordService {

    private final PlayerStatDAO recordDAO;

    public RecordService(PlayerStatDAO recordDAO) {
        this.recordDAO = recordDAO;
    }

    public List<HitterStat> getAllRecords() {
        return recordDAO.findAllByOrderByDateDesc();
    }
}
