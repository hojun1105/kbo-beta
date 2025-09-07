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

        h2 {
            color: #0a0a23;
            margin-bottom: 30px;
            text-align: center;
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
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            padding: 15px 10px;
            border: 1px solid #e0e0e0;
            font-size: 14px;
            text-align: center;
        }

        th {
            background-color: #0a0a23;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        /* KBO 팀별 색상 */
        tr[data-team="두산 베어스"] {
            background-color: #131230;
            color: white;
        }
        tr[data-team="두산 베어스"]:hover {
            background-color: #1a1a3a;
        }
        
        tr[data-team="LG 트윈스"] {
            background-color: #c30452;
            color: white;
        }
        tr[data-team="LG 트윈스"]:hover {
            background-color: #d3055a;
        }
        
        tr[data-team="키움 히어로즈"] {
            background-color: #570514;
            color: white;
        }
        tr[data-team="키움 히어로즈"]:hover {
            background-color: #67061a;
        }
        
        tr[data-team="SSG 랜더스"] {
            background-color: #ce0e2d;
            color: white;
        }
        tr[data-team="SSG 랜더스"]:hover {
            background-color: #de1e3d;
        }
        
        tr[data-team="한화 이글스"] {
            background-color: #ff6600;
            color: white;
        }
        tr[data-team="한화 이글스"]:hover {
            background-color: #ff7700;
        }
        
        tr[data-team="NC 다이노스"] {
            background-color: #315288;
            color: white;
        }
        tr[data-team="NC 다이노스"]:hover {
            background-color: #416298;
        }
        
        tr[data-team="롯데 자이언츠"] {
            background-color: #041e42;
            color: white;
        }
        tr[data-team="롯데 자이언츠"]:hover {
            background-color: #142e52;
        }
        
        tr[data-team="삼성 라이온즈"] {
            background-color: #1d4d72;
            color: white;
        }
        tr[data-team="삼성 라이온즈"]:hover {
            background-color: #2d5d82;
        }
        
        tr[data-team="KIA 타이거즈"] {
            background-color: #ea0029;
            color: white;
        }
        tr[data-team="KIA 타이거즈"]:hover {
            background-color: #fa1039;
        }
        
        tr[data-team="kt 위즈"] {
            background-color: #000000;
            color: white;
        }
        tr[data-team="kt 위즈"]:hover {
            background-color: #1a1a1a;
        }
    </style>
    <script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>

</head>
<body>

<h2>기록</h2>
<div id="filters" class="filters" style="display:flex;align-items:flex-end;gap:16px;max-width:1200px;margin:0 auto 20px auto;flex-wrap:wrap;">
    <div class="filter-group" style="display:flex;flex-direction:column;gap:6px;">
        <label for="teamFilter" style="font-size:13px;color:#444;">팀</label>
        <select id="teamFilter" style="padding:8px 10px;border:1px solid #cfd4dc;border-radius:8px;background:#fff;min-width:160px;font-size:14px;">
            <option value="">전체</option>
            <option value="두산 베어스">두산 베어스</option>
            <option value="LG 트윈스">LG 트윈스</option>
            <option value="키움 히어로즈">키움 히어로즈</option>
            <option value="SSG 랜더스">SSG 랜더스</option>
            <option value="한화 이글스">한화 이글스</option>
            <option value="NC 다이노스">NC 다이노스</option>
            <option value="롯데 자이언츠">롯데 자이언츠</option>
            <option value="삼성 라이온즈">삼성 라이온즈</option>
            <option value="KIA 타이거즈">KIA 타이거즈</option>
            <option value="kt 위즈">kt 위즈</option>
        </select>
    </div>
    <div class="filter-group" id="positionFilterGroup" style="display:flex;flex-direction:column;gap:6px;">
        <label for="positionFilter" style="font-size:13px;color:#444;">포지션</label>
        <select id="positionFilter" style="padding:8px 10px;border:1px solid #cfd4dc;border-radius:8px;background:#fff;min-width:160px;font-size:14px;">
            <option value="">전체</option>
            <option value="포수">포수</option>
            <option value="내야수">내야수</option>
            <option value="외야수">외야수</option>
            <option value="지명타자">지명타자</option>
        </select>
    </div>
    <div class="view-modes" style="display:flex;gap:8px;margin-left:auto;">
        <button id="resetFilters" class="reset-btn" type="button" style="background:#f1f3f5;color:#0a0a23;border:1px solid #cfd4dc;padding:8px 14px;border-radius:8px;cursor:pointer;">초기화</button>
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
        
        // 포지션 필터 표시/숨김 처리
        const positionFilterGroup = document.getElementById('positionFilterGroup');
        if (tabId === 'hitting') {
            positionFilterGroup.style.display = 'flex';
        } else if (tabId === 'pitching') {
            positionFilterGroup.style.display = 'none';
            // 포지션 필터 초기화
            positionFilter.value = '';
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
        const activeTab = document.querySelector('.tab-btn.active').textContent.toLowerCase();
        const rows = document.querySelectorAll(activeTab === 'hitting' ? '#hitting tbody tr' : '#pitching tbody tr');
        const team = (teamFilter.value || '').trim();
        const position = (positionFilter.value || '').trim();

        rows.forEach(row => {
            const rt = (row.getAttribute('data-team') || '').trim();
            const rp = (row.getAttribute('data-position') || '').trim();
            
            let positionMatch = true;
            if (position && activeTab === 'hitting') {
                if (position === '내야수') {
                    positionMatch = ['1루수', '2루수', '3루수', '유격수'].includes(rp);
                } else if (position === '외야수') {
                    positionMatch = ['좌익수', '중견수', '우익수'].includes(rp);
                } else if (position === '포수') {
                    positionMatch = rp === '포수';
                } else if (position === '지명타자') {
                    positionMatch = rp === '지명타자';
                } else {
                    positionMatch = position === rp;
                }
            } else if (activeTab === 'pitching') {
                // Pitching 탭에서는 포지션 필터 무시 (모든 투수 표시)
                positionMatch = true;
            }
            
            const show = (!team || team === rt) && positionMatch;
            row.style.display = show ? '' : 'none';
        });
    }

    window.addEventListener('DOMContentLoaded', () => {
        populateOptions();
        applyFilters();
        teamFilter.addEventListener('change', applyFilters);
        positionFilter.addEventListener('change', applyFilters);
        document.getElementById('resetFilters').addEventListener('click', () => {
            teamFilter.value = '';
            positionFilter.value = '';
            applyFilters();
        });
        
        // 디버깅용: 실제 포지션 데이터 확인
        console.log('실제 포지션 데이터:');
        const hittingRows = document.querySelectorAll('#hitting tbody tr');
        const positions = new Set();
        hittingRows.forEach(row => {
            const pos = row.getAttribute('data-position');
            if (pos) positions.add(pos);
        });
        console.log(Array.from(positions));
    });
</script>
</html>
