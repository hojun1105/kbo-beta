<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 - 글쓰기</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <jsp:include page="common/styles.jsp"/>
    <style>
        .content { max-width: 900px; margin: 40px auto; background: #fdfdfd; padding: 30px; border-radius: 12px; border: 2px solid #111; box-shadow: 0 2px 10px rgba(0,0,0,0.15); }
        .page-header { display:flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 16px; border-bottom: 2px solid #f0f0f0; }
        .page-title { color: #c30452; margin: 0; font-size: 1.8em; }
        .form-group { margin-bottom: 16px; }
        .form-group label { display:block; margin-bottom: 8px; }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }
        .btn-row { display:flex; gap: 8px; }
        .btn { display:inline-block; padding: 10px 16px; border-radius: 8px; text-decoration:none; border:1px solid #ddd; color:#333; background:#fff; }
        .btn-primary { background:#c30452; color:#fff; border-color:#c30452; }
        .hint { color:#666; font-size:12px; margin-top:6px; }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="community"/>
</jsp:include>

<div class="content">
    <div class="page-header">
        <h1 class="page-title">글쓰기</h1>
    </div>
    <form method="post" action="<c:url value='/community/write'/>">
        <div class="form-group">
            <label for="title">제목</label>
            <input id="title" name="title" type="text" required maxlength="150" />
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" rows="12" required maxlength="5000"></textarea>
        </div>
        <div class="btn-row">
            <button type="submit" class="btn btn-primary">등록</button>
            <a class="btn" href="<c:url value='/community'/>">취소</a>
        </div>
    </form>
    
</div>

<jsp:include page="common/footer.jsp"/>

 

</body>
</html>


