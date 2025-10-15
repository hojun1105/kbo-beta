package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.model.CommunityPost;
import org.example.service.CommunityService;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
 

@Controller
public class CommunityController {

    private final CommunityService communityService;

    public CommunityController(CommunityService communityService) {
        this.communityService = communityService;
    }

    @GetMapping("/community")
    public String communityPage(HttpServletRequest request,
                                Model model,
                                @RequestParam(defaultValue = "0") int page,
                                @RequestParam(defaultValue = "10") int size) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);

        Page<CommunityPost> postPage = communityService.getPostPage(page, size);
        model.addAttribute("postPage", postPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);

        return "community";
    }

    @GetMapping("/community/write")
    public String writeForm(HttpServletRequest request, Model model) {
        String userId = (String) request.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", true);
        return "community_write";
    }

    @PostMapping("/community/write")
    public String submitPost(HttpServletRequest request,
                             @RequestParam String title,
                             @RequestParam String content) {
        String userId = (String) request.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        communityService.createPost(title, content, userId);
        return "redirect:/community";
    }

    @GetMapping("/community/{id}")
    public String viewDetail(@PathVariable("id") Long id,
                             HttpServletRequest request,
                             Model model) {
        String userId = (String) request.getAttribute("userId");
        model.addAttribute("userId", userId);
        model.addAttribute("isLoggedIn", userId != null);

        CommunityPost post = communityService.getPostAndIncreaseViews(id);
        if (post == null) {
            model.addAttribute("error", "게시글을 찾을 수 없습니다.");
            return "errorPage";
        }
        model.addAttribute("post", post);
        model.addAttribute("comments", communityService.getComments(id));
        model.addAttribute("upvotes", communityService.getUpvoteCount(id));
        model.addAttribute("downvotes", communityService.getDownvoteCount(id));
        return "community_detail";
    }

    @PostMapping("/community/{id}/comment")
    public String addComment(@PathVariable("id") Long id,
                             HttpServletRequest request,
                             @RequestParam String content) {
        String userId = (String) request.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        communityService.addComment(id, userId, content);
        return "redirect:/community/" + id;
    }

    @PostMapping("/community/{id}/vote")
    public String vote(@PathVariable("id") Long id,
                       HttpServletRequest request,
                       @RequestParam("type") String type) {
        String userId = (String) request.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        int vote = "up".equals(type) ? 1 : -1;
        communityService.votePost(id, userId, vote);
        return "redirect:/community/" + id;
    }

}


