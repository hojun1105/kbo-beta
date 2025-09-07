<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>KBO 선수 기록</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            padding: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            font-size: 13px;
            text-align: center;
        }

        th {
            background-color: #0a0a23;
            color: white;
        }

        tr:hover {
            background-color: #f9f9f9;
        }
    </style>
    <script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>

</head>
<body>

<h2>기록</h2>
<div id="tabs">
    <button class="tab-btn active" onclick="showTab('hitting')">Hitting</button>
    <button class="tab-btn" onclick="showTab('pitching')">Pitching</button>
</div>
<div id="hitting" class="tab-content">
    <table class="sortable">
    <thead>
    <tr>
        <th>선수명</th><th>팀명</th><th>AVG</th><th>G</th><th>PA</th><th>AB</th>
        <th>R</th><th>H</th><th>2B</th><th>3B</th><th>HR</th><th>TB</th><th>RBI</th><th>SAC</th><th>SF</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="p" items="${records}">
        <tr>
            <td>${p.player.name}</td>
            <td>${p.player.team.name}</td>
            <td>${p.average}</td>
            <td>${p.games}</td>
            <td>${p.plateAppearances}</td>
            <td>${p.atBat}</td>
            <td>${p.runs}</td>
            <td>${p.hits}</td>
            <td>${p.doubleBase}</td>
            <td>${p.tripleBase}</td>
            <td>${p.homeRun}</td>
            <td>${p.totalBase}</td>
            <td>${p.runsBattedIn}</td>
            <td>${p.sacrificeHit}</td>
            <td>${p.sacrificeFly}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<!-- 투수 기록 -->
<div id="pitching" class="tab-content" style="display:none;">
    <table>
        <thead>
        <tr>
            <th>선수명</th><th>팀명</th><th>ERA</th><th>G</th><th>W</th><th>L</th><th>SV</th><th>IP</th><th>SO</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${pitchers}">
            <tr>
                <td>${p.player.name}</td>
                <td>${p.player.team.name}</td>
                <td>${p.era}</td>
                <td>${p.games}</td>
                <td>${p.wins}</td>
                <td>${p.losses}</td>
                <td>${p.saves}</td>
                <td>${p.inningsPitched}</td>
                <td>${p.strikeOuts}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>

<script>
    function showTab(tabId) {
        // 모든 탭 숨기기
        document.querySelectorAll('.tab-content').forEach(e => e.style.display = 'none');
        document.querySelectorAll('.tab-btn').forEach(e => e.classList.remove('active'));

        // 해당 탭만 보이기
        document.getElementById(tabId).style.display = 'block';
        event.target.classList.add('active');
    }
</script>
</html>
