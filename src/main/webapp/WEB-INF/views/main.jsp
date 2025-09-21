<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KBO 팬 허브 - 오늘의 트윈스</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            color: #222;
        }
        .logo-img {
            height: 60px;
            vertical-align: middle;
        }
        /* 상단 네비게이션 바 */
        .navbar {
            background-color: #0a0a23;
            padding: 0 40px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .navbar-left {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .navbar-brand {
            color: white;
            font-size: 1.4em;
            font-weight: bold;
        }

        .nav-group-left,
        .nav-group-right {
            display: flex;
            gap: 20px;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: 600;
            padding: 6px 0;
            border-bottom: 3px solid transparent;
            transition: border 0.2s ease;
        }

        .nav-link:hover,
        .nav-link.active {
            border-bottom: 3px solid #c30452;
        }

        /* 본문 예시 */
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
        footer {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #f8f9fa;
            text-align: center;
            padding: 10px 0;
        }

    </style>
</head>
<body>

<div class="navbar">
    <div class="navbar-left">
        <a href="../.." class="navbar-brand">
            <img src="${pageContext.request.contextPath}/images/kbo.png" alt="KBO 팬 허브 로고" class="logo-img">
        </a>
        <div class="nav-group-left">
            <a href="<c:url value="/html/predict.html"/>" class="nav-link">오늘의 경기</a>
            <a href="<c:url value="/html/playerStat.html"/>" class="nav-link">선수별 분석</a>
            <c:if test="${isLoggedIn}">
                <a href="<c:url value="/record"/>" class="nav-link">자료실</a>
                <a href="#" class="nav-link">커뮤니티</a>
            </c:if>
        </div>
    </div>
    <div class="nav-group-right">
        <c:choose>
            <c:when test="${isLoggedIn}">
                <a href="<c:url value="/userInfo"/>" class="nav-link">내 정보</a>
                <a href="/logout" class="nav-link">로그아웃</a>
            </c:when>
            <c:otherwise>
                <a href="../../html/login.html" class="nav-link">로그인</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 본문 -->
<div class="content">
    <h2>오늘의 트윈스</h2>
    <p>경기 예측과 선수 분석 정보를 이곳에서 확인하세요!</p>
</div>
<footer>
    © 2025 KBO 팬허브
</footer>
</body>
</html>
