package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Value;

public final class StoreDto {

    private StoreDto() {
    }

    @Value
    @Builder
    public static class Response {
        Integer id;
        String name;
        String category;
        String visitorReviews;
        String blogReviews;
        String operatingHours;
        String address;
        String phoneNum;
        String searchKeyword;
        String location;
        String naverPlaceId;
        Double latitude;
        Double longitude;
    }
}



