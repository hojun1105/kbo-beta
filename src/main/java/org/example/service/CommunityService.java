package org.example.service;

import org.example.dao.CommunityPostDAO;
import org.example.dao.CommunityCommentDAO;
import org.example.dao.CommunityPostVoteDAO;
import org.example.model.CommunityPost;
import org.example.model.CommunityComment;
import org.example.model.CommunityPostVote;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CommunityService {

    private final CommunityPostDAO communityPostDAO;
    private final CommunityCommentDAO communityCommentDAO;
    private final CommunityPostVoteDAO communityPostVoteDAO;

    public CommunityService(CommunityPostDAO communityPostDAO,
                            CommunityCommentDAO communityCommentDAO,
                            CommunityPostVoteDAO communityPostVoteDAO) {
        this.communityPostDAO = communityPostDAO;
        this.communityCommentDAO = communityCommentDAO;
        this.communityPostVoteDAO = communityPostVoteDAO;
    }

    public Page<CommunityPost> getPostPage(int page, int size) {
        int safePage = Math.max(page, 0);
        int safeSize = Math.min(Math.max(size, 1), 50);
        Pageable pageable = PageRequest.of(safePage, safeSize);
        return communityPostDAO.findAllOrderByCreatedAtDesc(pageable);
    }

    public CommunityPost createPost(String title, String content, String username) {
        CommunityPost post = CommunityPost.builder()
                .title(title)
                .content(content)
                .username(username)
                .build();
        return communityPostDAO.save(post);
    }

    @Transactional
    public CommunityPost getPostAndIncreaseViews(Long id) {
        CommunityPost post = communityPostDAO.findById(id).orElse(null);
        if (post == null) {
            return null;
        }
        post.setViews(post.getViews() + 1);
        return post;
    }

    public java.util.List<CommunityComment> getComments(Long postId) {
        return communityCommentDAO.findByPostIdOrderByCreatedAtAsc(postId);
    }

    public CommunityComment addComment(Long postId, String username, String content) {
        CommunityComment comment = CommunityComment.builder()
                .postId(postId)
                .username(username)
                .content(content)
                .build();
        return communityCommentDAO.save(comment);
    }

    @Transactional
    public int votePost(Long postId, String username, int vote) {
        CommunityPostVote existing = communityPostVoteDAO.findByPostIdAndUsername(postId, username);
        if (existing == null) {
            CommunityPostVote v = CommunityPostVote.builder().postId(postId).username(username).vote(vote).build();
            communityPostVoteDAO.save(v);
        } else {
            existing.setVote(vote);
        }
        return communityPostVoteDAO.sumVotesByPostId(postId);
    }

    public int getUpvoteCount(Long postId) {
        return communityPostVoteDAO.countUpvotesByPostId(postId);
    }

    public int getDownvoteCount(Long postId) {
        return communityPostVoteDAO.countDownvotesByPostId(postId);
    }
}
