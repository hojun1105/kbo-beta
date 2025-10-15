package org.example.dao;

import org.example.model.CommunityPost;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CommunityPostDAO extends JpaRepository<CommunityPost, Long> {

    @Query("SELECT p FROM CommunityPost p ORDER BY p.createdAt DESC")
    Page<CommunityPost> findAllOrderByCreatedAtDesc(Pageable pageable);
}


