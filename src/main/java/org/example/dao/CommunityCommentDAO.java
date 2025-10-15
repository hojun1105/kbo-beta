package org.example.dao;

import org.example.model.CommunityComment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommunityCommentDAO extends JpaRepository<CommunityComment, Long> {
    List<CommunityComment> findByPostIdOrderByCreatedAtAsc(Long postId);
}


