package org.example.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.dto.StoreDto;
import org.example.model.Store;
import org.example.repository.StoreRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class StoreService {

    private final StoreRepository storeRepository;

    @Transactional(readOnly = true)
    public List<StoreDto.Response> getStoresByLocation(String location) {
        List<Store> stores = storeRepository.findByLocationOrderByName(location);
        return stores.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<String> getAllLocations() {
        return storeRepository.findAllLocations();
    }

    @Transactional(readOnly = true)
    public List<StoreDto.Response> getAllStores() {
        return storeRepository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    private StoreDto.Response toResponse(Store store) {
        return StoreDto.Response.builder()
                .id(store.getId())
                .name(store.getName())
                .category(store.getCategory())
                .visitorReviews(store.getVisitorReviews())
                .blogReviews(store.getBlogReviews())
                .operatingHours(store.getOperatingHours())
                .address(store.getAddress())
                .phoneNum(store.getPhoneNum())
                .searchKeyword(store.getSearchKeyword())
                .location(store.getLocation())
                .naverPlaceId(store.getNaverPlaceId())
                .latitude(store.getLatitude())
                .longitude(store.getLongitude())
                .build();
    }
}



