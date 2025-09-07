package controller;

import model.HitterStat;
import model.PitcherStat;
import model.PlayerStat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import service.RecordService;

import java.util.List;

@Controller
public class RecordController {

    private final RecordService recordService;

    public RecordController(RecordService recordService) {
        this.recordService = recordService;
    }

    @GetMapping("/record")
    public String showRecords(Model model) {
        List<HitterStat> records = recordService.getAllRecords();
        List<PitcherStat> pitchers = recordService.getAllPitcherRecords();
        model.addAttribute("records", records);
        model.addAttribute("pitchers", pitchers);
        return "record"; // → /WEB-INF/views/record.jsp
    }
}
