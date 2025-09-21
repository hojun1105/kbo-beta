package org.example.service;

import org.example.dao.PlayerStatDAO;
import org.example.dao.PitcherStatDAO;
import org.example.model.HitterStat;
import org.example.model.PitcherStat;
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
