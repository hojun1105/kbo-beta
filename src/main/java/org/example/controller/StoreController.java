package org.example.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.example.dto.StoreDto;
import org.example.service.StoreService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class StoreController {

    private final StoreService storeService;
    private final ObjectMapper objectMapper;

    @Value("${naver.map.client-id:}")
    private String naverMapClientId;

    @GetMapping("/restaurants")
    public String viewStores(@RequestParam(value = "location", required = false) String location,
                             Model model,
                             HttpServletRequest request) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("activePage", "restaurants");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);
        
        // 네이버 지도 Client ID 추가
        model.addAttribute("naverMapClientId", naverMapClientId);

        // stores 테이블에서 location 목록 가져오기
        List<String> locations = storeService.getAllLocations();
        model.addAttribute("locations", locations);

        List<StoreDto.Response> stores;
        if (location != null && !location.isEmpty()) {
            model.addAttribute("selectedLocation", location);
            stores = storeService.getStoresByLocation(location);
        } else if (!locations.isEmpty()) {
            String defaultLocation = locations.get(0);
            model.addAttribute("selectedLocation", defaultLocation);
            stores = storeService.getStoresByLocation(defaultLocation);
        } else {
            model.addAttribute("selectedLocation", "");
            stores = List.of();
        }

        // ObjectMapper로 JSON 변환
        try {
            String storesJson = objectMapper.writeValueAsString(stores);
            model.addAttribute("storesJson", storesJson);
        } catch (Exception e) {
            model.addAttribute("storesJson", "[]");
        }
        model.addAttribute("stores", stores);

        return "restaurants";
    }
}

