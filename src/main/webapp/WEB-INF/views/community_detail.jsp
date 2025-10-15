<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 - 상세</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <jsp:include page="common/styles.jsp"/>
    <style>
        .content { max-width: 900px; margin: 40px auto; background: #fdfdfd; padding: 30px; border-radius: 12px; border: 2px solid #111; box-shadow: 0 2px 10px rgba(0,0,0,0.15); }
        .page-header { display:flex; justify-content: space-between; align-items: end; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 2px solid #f0f0f0; }
        .page-title { color: #c30452; margin: 0; font-size: 1.8em; }
        .post-title { font-size: 22px; font-weight: 700; margin-bottom: 8px; }
        .meta { color: #666; font-size: 14px; margin-bottom: 16px; }
        .post-body { white-space: pre-wrap; line-height: 1.6; }
        .btn-row { display:flex; gap: 8px; margin-top: 16px; }
        .btn { display:inline-block; padding: 10px 16px; border-radius: 8px; text-decoration:none; border:1px solid #ddd; color:#333; background:#fff; }
        .btn-primary { background:#c30452; color:#fff; border-color:#c30452; }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="community"/>
</jsp:include>

<div class="content">
    <div class="page-header">
        <h1 class="page-title">게시글</h1>
        <a class="btn" href="<c:url value='/community'/>">목록</a>
    </div>
    <div class="post-title">${post.title}</div>
    <div class="meta">작성자: ${post.username} | 작성일: ${post.createdAt} | 조회수: ${post.views}</div>
    <div class="post-body">${post.content}</div>
    <div style="margin-top: 20px; display:flex; gap: 8px; align-items:center;">
        <form method="post" action="<c:url value='/community/${post.id}/vote'/>" style="display:inline;">
            <input type="hidden" name="type" value="up" />
            <button type="submit" class="btn" style="background:#16a34a;color:#fff;border-color:#0f8a3c;transition:transform .05s;" onmousedown="this.style.transform='scale(0.97)';" onmouseup="this.style.transform='scale(1)';">추천 <span>+${upvotes}</span></button>
        </form>
        <form method="post" action="<c:url value='/community/${post.id}/vote'/>" style="display:inline;">
            <input type="hidden" name="type" value="down" />
            <button type="submit" class="btn" style="background:#dc2626;color:#fff;border-color:#b91c1c;transition:transform .05s;" onmousedown="this.style.transform='scale(0.97)';" onmouseup="this.style.transform='scale(1)';">비추천 <span>-${downvotes}</span></button>
        </form>
    </div>

    <div style="margin-top: 30px; border-top: 2px solid #f0f0f0; padding-top: 16px;">
        <h3 style="margin:0 0 12px 0;">댓글</h3>
        <c:choose>
            <c:when test="${not empty comments}">
                <ul style="list-style:none; padding:0; margin:0;">
                    <c:forEach var="cmt" items="${comments}">
                        <li style="border-bottom:1px solid #e5e5e5; padding:10px 4px;">
                            <div style="font-size:14px; color:#555; margin-bottom:4px;">${cmt.username} · ${cmt.createdAt}</div>
                            <div>${cmt.content}</div>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div style="color:#777;">첫 댓글을 남겨보세요.</div>
            </c:otherwise>
        </c:choose>

        <c:if test="${isLoggedIn}">
            <form method="post" action="<c:url value='/community/${post.id}/comment'/>" style="margin-top:12px;">
                <textarea name="content" rows="3" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px;" required maxlength="2000"></textarea>
                <div class="btn-row">
                    <button type="submit" class="btn btn-primary">댓글 작성</button>
                </div>
            </form>
        </c:if>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>


</body>
</html>


