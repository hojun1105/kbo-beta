package org.example.controller;

import org.example.model.HitterStat;
import org.example.model.PitcherStat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.example.service.RecordService;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class RecordController {

    private final RecordService recordService;

    public RecordController(RecordService recordService) {
        this.recordService = recordService;
    }

    @GetMapping("/record")
    public String showRecords(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        
        List<HitterStat> records = recordService.getAllRecords();
        List<PitcherStat> pitchers = recordService.getAllPitcherRecords();
        model.addAttribute("records", records);
        model.addAttribute("pitchers", pitchers);
        return "record";
    }
}
