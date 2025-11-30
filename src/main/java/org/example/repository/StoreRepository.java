package org.example.repository;

import org.example.model.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StoreRepository extends JpaRepository<Store, Integer> {

    List<Store> findByLocation(String location);

    @Query("SELECT s FROM Store s WHERE s.location = :location ORDER BY s.name ASC")
    List<Store> findByLocationOrderByName(@Param("location") String location);

    @Query("SELECT DISTINCT s.location FROM Store s WHERE s.location IS NOT NULL AND s.location != '' ORDER BY s.location")
    List<String> findAllLocations();
}

