package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.example.service.StoreService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class StoreController {

    private final StoreService storeService;

    @GetMapping("/restaurants")
    public String viewStores(@RequestParam(value = "location", required = false) String location,
                             Model model,
                             HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("activePage", "restaurants");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);

        // stores 테이블에서 location 목록 가져오기
        List<String> locations = storeService.getAllLocations();
        model.addAttribute("locations", locations);

        if (location != null && !location.isEmpty()) {
            model.addAttribute("selectedLocation", location);
            model.addAttribute("stores", storeService.getStoresByLocation(location));
        } else if (!locations.isEmpty()) {
            String defaultLocation = locations.get(0);
            model.addAttribute("selectedLocation", defaultLocation);
            model.addAttribute("stores", storeService.getStoresByLocation(defaultLocation));
        } else {
            model.addAttribute("selectedLocation", "");
            model.addAttribute("stores", List.of());
        }

        return "restaurants";
    }
}

