package org.example.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "naver_stores")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String name;

    @Column(length = 100)
    private String category;

    @Column(name = "visitor_reviews", length = 50)
    private String visitorReviews;

    @Column(name = "blog_reviews", length = 50)
    private String blogReviews;

    @Column(name = "operating_hours", columnDefinition = "TEXT")
    private String operatingHours;

    @Column(length = 255)
    private String address;

    @Column(name = "phone_num", length = 50)
    private String phoneNum;

    @Column(name = "search_keyword", length = 255)
    private String searchKeyword;

    @Column(length = 255)
    private String location;  // 경기장 정보

    @Column(name = "naver_place_id", length = 50, unique = true)
    private String naverPlaceId;

    @Column(name = "latitude")
    private Double latitude;

    @Column(name = "longitude")
    private Double longitude;
}

