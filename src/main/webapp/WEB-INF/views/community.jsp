<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KBO 팬 허브 - 커뮤니티</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <jsp:include page="common/styles.jsp"/>
    <style>
        .content {
            max-width: 1200px;
            margin: 40px auto;
            background: #fdfdfd;
            padding: 30px;
            border-radius: 12px;
            border: 2px solid #111;
            box-shadow: 0 2px 10px rgba(0,0,0,0.15);
        }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 16px; border-bottom: 2px solid #f0f0f0; }
        .page-title { color: #c30452; margin: 0; font-size: 1.8em; }
        .btn { display:inline-block; padding: 10px 16px; border-radius: 8px; text-decoration:none; border:1px solid #ddd; color:#333; background:#fff; }
        .btn-primary { background:#c30452; color:#fff; border-color:#c30452; }
        .btn:hover { opacity: .9; }
        .table { width: 100%; border-collapse: collapse; border: 1px solid #111; }
        .table th, .table td { padding: 12px 10px; border: 1px solid #111; text-align: left; }
        .table thead th { background: #f7f7f7; }
        .table tbody tr:hover { background: #f3f3f3; }
        .placeholder { color: #777; margin-top: 12px; }
        .pagination-container { margin-top: 30px; padding-top: 20px; border-top: 1px solid #e0e0e0; display: flex; justify-content: center; align-items: center; gap: 15px; }
        .pagination-btn { 
            display: inline-block; 
            padding: 6px 12px; 
            border-radius: 4px; 
            text-decoration: none; 
            border: 1px solid #ddd; 
            color: #333; 
            background: #fff; 
            font-size: 13px;
            transition: all 0.2s ease; 
            width: auto;
        }
        .pagination-btn:hover { 
            background: #c30452; 
            color: #fff; 
            border-color: #c30452;
        }
        .pagination-btn.disabled { 
            background: #f5f5f5; 
            color: #999; 
            border-color: #ddd; 
            cursor: not-allowed;
        }
        .page-info { 
            padding: 6px 12px; 
            background: #f8f8f8; 
            border: 1px solid #ddd; 
            border-radius: 4px; 
            font-size: 13px; 
            color: #333; 
            font-weight: normal;
        }
    </style>
    
</head>
<body>

<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="community"/>
    <jsp:param name="isLoggedIn" value="${isLoggedIn}"/>
    <jsp:param name="userId" value="${userId}"/>
    
</jsp:include>

<div class="content">
    <div class="page-header">
        <h1 class="page-title">커뮤니티</h1>
        <c:if test="${isLoggedIn}">
            <a href="<c:url value='/community/write'/>" class="btn btn-primary">글쓰기</a>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${not empty postPage and postPage.totalElements > 0}">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width:60px;">번호</th>
                        <th>제목</th>
                        <th style="width:160px;">작성자</th>
                        <th style="width:140px;">작성일</th>
                        <th style="width:100px;">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="post" items="${postPage.content}">
                        <tr>
                            <td>${post.id}</td>
                            <td><a href="<c:url value='/community/${post.id}'/>">${post.title}</a></td>
                            <td>${post.username}</td>
                            <td>${post.createdAt}</td>
                            <td>${post.views}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="pagination-container">
                <c:set var="prevPage" value="${currentPage - 1}"/>
                <c:set var="nextPage" value="${currentPage + 1}"/>
                
                <c:choose>
                    <c:when test="${currentPage > 0}">
                        <a class="pagination-btn" href="<c:url value='/community?page=${prevPage}&size=${pageSize}'/>">
                            ← 이전
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="pagination-btn disabled">← 이전</span>
                    </c:otherwise>
                </c:choose>
                
                <div class="page-info">
                    ${currentPage + 1} / ${postPage.totalPages}
                </div>
                
                <c:choose>
                    <c:when test="${currentPage < postPage.totalPages - 1}">
                        <a class="pagination-btn" href="<c:url value='/community?page=${nextPage}&size=${pageSize}'/>">
                            다음 →
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="pagination-btn disabled">다음 →</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>
        <c:otherwise>
            <p class="placeholder">게시글이 없습니다. 첫 글을 작성해보세요.</p>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="common/footer.jsp"/>


</body>
</html>


