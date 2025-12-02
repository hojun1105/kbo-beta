<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자료실 - KBO 팬 허브</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <jsp:include page="common/styles.jsp"/>
    <style>
        .content-wrapper {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h2 {
            color: #c30452;
            margin-bottom: 30px;
            text-align: center;
            font-size: 2em;
        }

        #tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            gap: 10px;
        }

        .tab-btn {
            background-color: #fff;
            border: 2px solid #0a0a23;
            color: #0a0a23;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.3s ease;
            min-width: 120px;
        }

        .tab-btn:hover {
            background-color: #0a0a23;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(10, 10, 35, 0.3);
        }

        .tab-btn.active {
            background-color: #0a0a23;
            color: white;
            box-shadow: 0 4px 12px rgba(10, 10, 35, 0.3);
        }

        .tab-content {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-height: 80vh;
            overflow-y: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            padding: 8px 6px;
            border: 1px solid #e0e0e0;
            font-size: 12px;
            text-align: center;
        }

        th {
            background-color: #0a0a23;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            font-size: 11px;
            padding: 6px 4px;
            position: sticky;
            top: 0;
            z-index: 10;
            box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.1);
        }

        tr:hover {
            background-color: #f8f9fa;
        }
        
        tr {
            height: 32px;
        }
        
        td {
            vertical-align: middle;
        }
        
        /* 숫자 데이터 스타일 */
        td:nth-child(n+3) {
            font-family: 'Noto Sans KR', sans-serif;
            font-weight: 400;
        }

        /* KBO 팀별 색상 - 팀명 셀에만 적용 */
        tr[data-team="Doosan Bears"] td:nth-child(2) {
            background-color: #131230;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="LG Twins"] td:nth-child(2) {
            background-color: #c30452;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="Kiwoom Heroes"] td:nth-child(2) {
            background-color: #570514;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="SSG Landers"] td:nth-child(2) {
            background-color: #ce0e2d;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="Hanwha Eagles"] td:nth-child(2) {
            background-color: #ff6600;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="NC Dinos"] td:nth-child(2) {
            background-color: #315288;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="Lotte Giants"] td:nth-child(2) {
            background-color: #041e42;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="Samsung Lions"] td:nth-child(2) {
            background-color: #1d4d72;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="KIA Tigers"] td:nth-child(2) {
            background-color: #ea0029;
            color: white;
            font-weight: bold;
        }
        
        tr[data-team="KT Wiz"] td:nth-child(2) {
            background-color: #000000;
            color: white;
            font-weight: bold;
        }
    </style>
    <script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>
</head>
<body>

<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="record"/>
</jsp:include>

<div class="content-wrapper">
<h2>선수 기록</h2>
<div id="filters" class="filters" style="display:flex;align-items:flex-end;gap:12px;max-width:1200px;margin:0 auto 15px auto;flex-wrap:wrap;">
    <div class="filter-group" style="display:flex;flex-direction:column;gap:4px;">
        <label for="teamFilter" style="font-size:12px;color:#444;">팀</label>
        <select id="teamFilter" style="padding:6px 8px;border:1px solid #cfd4dc;border-radius:6px;background:#fff;min-width:140px;font-size:12px;">
            <option value="">전체</option>
            <option value="Doosan Bears">두산 베어스</option>
            <option value="LG Twins">LG 트윈스</option>
            <option value="Kiwoom Heroes">키움 히어로즈</option>
            <option value="SSG Landers">SSG 랜더스</option>
            <option value="Hanwha Eagles">한화 이글스</option>
            <option value="NC Dinos">NC 다이노스</option>
            <option value="Lotte Giants">롯데 자이언츠</option>
            <option value="Samsung Lions">삼성 라이온즈</option>
            <option value="KIA Tigers">KIA 타이거즈</option>
            <option value="KT Wiz">kt 위즈</option>
        </select>
    </div>
    <div class="filter-group" id="positionFilterGroup" style="display:flex;flex-direction:column;gap:4px;">
        <label for="positionFilter" style="font-size:12px;color:#444;">포지션</label>
        <select id="positionFilter" style="padding:6px 8px;border:1px solid #cfd4dc;border-radius:6px;background:#fff;min-width:140px;font-size:12px;">
            <option value="">전체</option>
            <option value="포수">포수</option>
            <option value="내야수">내야수</option>
            <option value="외야수">외야수</option>
            <option value="지명타자">지명타자</option>
        </select>
    </div>
    <div class="view-modes" style="display:flex;gap:6px;margin-left:auto;">
        <button id="resetFilters" class="reset-btn" type="button" style="background:#f1f3f5;color:#0a0a23;border:1px solid #cfd4dc;padding:6px 10px;border-radius:6px;cursor:pointer;font-size:11px;">초기화</button>
    </div>
    <hr style="margin-top:20px; border:none; border-top:1px solid #e5e5e5; width:100%"/>
    </div>
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
        <tr data-team="${p.player.team.name}" data-position="${p.player.position}" data-date="${p.date}">
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
    
    <!-- 디버깅용 정보 -->
    <script>
        console.log('JSP에서 전달된 데이터:');
        console.log('타자 기록 개수:', <c:out value="${fn:length(records)}" default="0"/>);
        console.log('투수 기록 개수:', <c:out value="${fn:length(pitchers)}" default="0"/>);
        <c:if test="${fn:length(records) > 0}">
        console.log('첫 번째 타자 정보:');
        console.log('- 이름:', '<c:out value="${records[0].player.name}"/>');
        console.log('- 팀:', '<c:out value="${records[0].player.team.name}"/>');
        console.log('- 포지션:', '<c:out value="${records[0].player.position}"/>');
        </c:if>
    </script>
</table>
</div>
<!-- 투수 기록 -->
<div id="pitching" class="tab-content" style="display:none;">
    <table class="sortable">
        <thead>
        <tr>
            <th>선수명</th><th>팀명</th><th>ERA</th><th>G</th><th>W</th><th>L</th><th>SV</th><th>IP</th><th>SO</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${pitchers}">
            <tr data-team="${p.player.team.name}" data-position="${p.player.position}" data-date="${p.date}">
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
        
        <!-- 디버깅용 정보 -->
        <script>
            console.log('투수 데이터 디버깅:');
            <c:if test="${fn:length(pitchers) > 0}">
            console.log('첫 번째 투수 정보:');
            console.log('- 이름:', '<c:out value="${pitchers[0].player.name}"/>');
            console.log('- 팀:', '<c:out value="${pitchers[0].player.team.name}"/>');
            console.log('- 포지션:', '<c:out value="${pitchers[0].player.position}"/>');
            </c:if>
        </script>
    </table>
</div>
</div>

<jsp:include page="common/footer.jsp"/>

<script>
    function showTab(tabId) {
        // 모든 탭 숨기기
        document.querySelectorAll('.tab-content').forEach(e => e.style.display = 'none');
        document.querySelectorAll('.tab-btn').forEach(e => e.classList.remove('active'));

        // 해당 탭만 보이기
        document.getElementById(tabId).style.display = 'block';
        event.target.classList.add('active');
        
        // 포지션 필터 표시/숨김 처리
        const positionFilterGroup = document.getElementById('positionFilterGroup');
        const positionFilter = document.getElementById('positionFilter');
        if (tabId === 'hitting') {
            positionFilterGroup.style.display = 'flex';
        } else if (tabId === 'pitching') {
            positionFilterGroup.style.display = 'none';
            // 포지션 필터 초기화
            if (positionFilter) {
                positionFilter.value = '';
            }
        }
        
        populateOptions();
        applyFilters();
    }

    const teamFilter = document.getElementById('teamFilter');
    const positionFilter = document.getElementById('positionFilter');

    function uniqueValues(selector, attr) {
        const nodes = Array.from(document.querySelectorAll(selector));
        const values = nodes.map(n => (n.getAttribute(attr) || '').trim()).filter(Boolean);
        return Array.from(new Set(values)).sort();
    }

    function populateOptions() {
        // 팀과 포지션 옵션은 이미 HTML에 하드코딩되어 있으므로 별도 처리 불필요
    }

    function applyFilters() {
        const activeTab = document.querySelector('.tab-btn.active');
        if (!activeTab) {
            console.log('활성 탭을 찾을 수 없습니다.');
            return;
        }
        
        const tabName = activeTab.textContent.toLowerCase();
        const rows = document.querySelectorAll(tabName === 'hitting' ? '#hitting tbody tr' : '#pitching tbody tr');
        const team = (teamFilter ? teamFilter.value || '' : '').trim();
        const position = (positionFilter ? positionFilter.value || '' : '').trim();

        console.log('필터 적용:', { tabName, team, position, rowsCount: rows.length });

        let visibleCount = 0;
        rows.forEach((row, index) => {
            const rt = (row.getAttribute('data-team') || '').trim();
            const rp = (row.getAttribute('data-position') || '').trim();
            
            let positionMatch = true;
            if (position && tabName === 'hitting') {
                const basePosition = rp.split('(')[0];

                if (position === '내야수') {
                    positionMatch = basePosition === "내야수";
                } else if (position === '외야수') {
                    positionMatch = basePosition === "외야수";
                } else if (position === '포수') {
                    positionMatch = basePosition === '포수';
                } else if (position === '지명타자') {
                    positionMatch = basePosition === '지명타자';
                } else {
                    positionMatch = (position === basePosition);
                }
            } else if (tabName === 'pitching') {
                // Pitching 탭에서는 포지션 필터 무시 (모든 투수 표시)
                positionMatch = true;
            }
            
            const teamMatch = !team || team === rt;
            const show = teamMatch && positionMatch;
            
            row.style.display = show ? '' : 'none';
            if (show) visibleCount++;
            
            // 디버깅용 로그 (처음 3개 행만)
            if (index < 3) {
                console.log(`행 ${index + 1} 필터링:`, { 
                    name: row.cells[0]?.textContent, 
                    rt, rp, teamMatch, positionMatch, show 
                });
            }
        });
        
        console.log(`필터링 완료: ${visibleCount}/${rows.length} 행이 표시됨`);
    }

    window.addEventListener('DOMContentLoaded', () => {
        populateOptions();
        applyFilters();
        
        if (teamFilter) {
            teamFilter.addEventListener('change', applyFilters);
        }
        if (positionFilter) {
            positionFilter.addEventListener('change', applyFilters);
        }
        
        const resetButton = document.getElementById('resetFilters');
        if (resetButton) {
            resetButton.addEventListener('click', () => {
                if (teamFilter) teamFilter.value = '';
                if (positionFilter) positionFilter.value = '';
                applyFilters();
            });
        }
        
        const testButton = document.getElementById('testFilter');
        if (testButton) {
            testButton.addEventListener('click', () => {
                console.log('=== 필터 테스트 시작 ===');
                console.log('현재 팀 필터:', teamFilter ? teamFilter.value : 'null');
                console.log('현재 포지션 필터:', positionFilter ? positionFilter.value : 'null');
                
                // 테스트: LG 트윈스 필터링
                if (teamFilter) {
                    teamFilter.value = 'LG 트윈스';
                    console.log('LG 트윈스로 필터링 테스트');
                    applyFilters();
                }
            });
        }
        
        // 디버깅용: 실제 데이터 확인
        console.log('=== 디버깅 정보 ===');
        console.log('타자 데이터 개수:', document.querySelectorAll('#hitting tbody tr').length);
        console.log('투수 데이터 개수:', document.querySelectorAll('#pitching tbody tr').length);
        
        // 타자 포지션 데이터 확인
        console.log('타자 포지션 데이터:');
        const hittingRows = document.querySelectorAll('#hitting tbody tr');
        const positions = new Set();
        const teams = new Set();
        hittingRows.forEach(row => {
            const pos = row.getAttribute('data-position');
            const team = row.getAttribute('data-team');
            if (pos) positions.add(pos);
            if (team) teams.add(team);
        });
        console.log('포지션:', Array.from(positions));
        console.log('팀:', Array.from(teams));
        
        // 첫 번째 행의 상세 정보 확인
        if (hittingRows.length > 0) {
            const firstRow = hittingRows[0];
            console.log('첫 번째 타자 행 정보:');
            console.log('- data-team:', firstRow.getAttribute('data-team'));
            console.log('- data-position:', firstRow.getAttribute('data-position'));
            console.log('- 실제 HTML:', firstRow.outerHTML);
        }
    });
</script>
</html>
