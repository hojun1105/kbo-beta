<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KBO 팬 허브 - 오늘의 트윈스</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <jsp:include page="common/styles.jsp"/>
    <style>
        .content {
            max-width: 1200px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        .content h2 {
            color: #c30452;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="main"/>
</jsp:include>

<div class="content">
    <h2>오늘의 트윈스</h2>
    <p>경기 예측과 선수 분석 정보를 이곳에서 확인하세요!</p>
</div>

<jsp:include page="common/footer.jsp"/>

</body>
</html>
