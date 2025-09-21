<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>오늘의 트윈스 - 승부 예측</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: repeating-linear-gradient(
                    to bottom,
                    #ffffff,
                    #ffffff 30px,
                    #eeeeee 31px,
                    #ffffff 32px
            );
            color: #222;
            padding: 30px 15px;
        }
        .container {
            max-width: 700px;
            margin: auto;
            background: rgba(255,255,255,0.95);
            padding: 40px;
            border-radius: 16px;
            border: 2px solid #c30452;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        h1 {
            text-align: center;
            color: #c30452;
            margin-bottom: 10px;
        }
        .matchup {
            text-align: center;
            font-size: 1.3em;
            margin-bottom: 30px;
        }
        .result-box {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }
        .team {
            font-weight: bold;
            font-size: 1.2em;
        }
        .prob {
            font-size: 1.1em;
            color: #333;
            margin-top: 5px;
        }
        .score {
            font-size: 1.2em;
            margin-top: 15px;
            color: #555;
        }
        .summary {
            font-size: 1em;
            color: #444;
            margin-top: 30px;
            line-height: 1.6em;
            text-align: center;
        }
        .btn-back {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            background: #c30452;
            color: white;
            padding: 10px 20px;
            border-radius: 12px;
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
            <a href="../../html/predict.html" class="nav-link active">오늘의 경기</a>
            <a href="../../html/playerStat.html" class="nav-link">선수별 분석</a>
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

<div class="container">
    <h1>오늘의 승부 예측</h1>
    <div class="matchup">LG 트윈스 🆚 두산 베어스</div>

    <div class="result-box">
        <div class="team">LG 트윈스 승률</div>
        <div class="prob">📈 67%</div>
        <div class="score">예상 점수: LG 6 - 두산 4</div>
    </div>

    <div class="summary">
        AI 분석 결과, LG 트윈스는 최근 5연승의 흐름과 선발 투수의 안정감으로<br>
        두산에 비해 승률 67%의 우세한 판세를 보이고 있습니다.<br><br>
        타선에서는 홍창기와 문성주의 출루율이 핵심 변수로 작용할 것으로 예상됩니다.
    </div>

    <div style="text-align: center;">
        <a href="<c:url value="/"/>" class="btn-back">← 돌아가기</a>
    </div>
</div>

<style>
    .navbar {
        background-color: #0a0a23;
        padding: 0 40px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        margin-bottom: 20px;
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

    .logo-img {
        height: 60px;
        vertical-align: middle;
    }
</style>

</body>
</html>

