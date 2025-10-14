<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>오늘의 트윈스 - 승부 예측</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="predict"/>
</jsp:include>


<div class="content">
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

<jsp:include page="common/footer.jsp"/>

</body>
</html>

