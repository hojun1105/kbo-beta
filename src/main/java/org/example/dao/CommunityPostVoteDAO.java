package org.example.dao;

import org.example.model.CommunityPostVote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CommunityPostVoteDAO extends JpaRepository<CommunityPostVote, Long> {

    CommunityPostVote findByPostIdAndUsername(Long postId, String username);

    @Query("SELECT COALESCE(SUM(v.vote), 0) FROM CommunityPostVote v WHERE v.postId = :postId")
    int sumVotesByPostId(Long postId);

    @Query("SELECT COUNT(v) FROM CommunityPostVote v WHERE v.postId = :postId AND v.vote = 1")
    int countUpvotesByPostId(Long postId);

    @Query("SELECT COUNT(v) FROM CommunityPostVote v WHERE v.postId = :postId AND v.vote = -1")
    int countDownvotesByPostId(Long postId);
}


