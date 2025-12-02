<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>경기 하이라이트 - KBO 팬 허브</title>
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
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .page-title {
            color: #c30452;
            margin: 0;
            font-size: 2em;
        }
        
        .team-filter {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .team-select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background: white;
        }
        
        .highlight-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }
        
        .highlight-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .highlight-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .video-container {
            position: relative;
            width: 100%;
            padding-bottom: 56.25%; /* 16:9 aspect ratio (9/16 = 0.5625) */
            background: #000;
            overflow: hidden;
        }
        
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }
        
        .highlight-info {
            padding: 20px;
        }
        
        .highlight-title {
            font-size: 1.2em;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .highlight-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            font-size: 0.9em;
            color: #666;
        }
        
        .team-vs {
            font-weight: bold;
            color: #c30452;
        }
        
        .highlight-description {
            color: #666;
            line-height: 1.5;
            margin-top: 10px;
        }
        
        .no-highlights {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .no-highlights h3 {
            margin-bottom: 10px;
            color: #999;
        }
        
        .loading {
            text-align: center;
            padding: 40px;
            color: #666;
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

<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="highlights"/>
</jsp:include>

<div class="content">
    <div class="page-header">
        <h1 class="page-title">오늘의 경기 하이라이트</h1>
        <div class="team-filter">
            <label for="teamSelect">팀별 필터:</label>
            <select id="teamSelect" class="team-select" onchange="filterByTeam()">
                <option value="">전체</option>
                <c:forEach var="team" items="${teams}">
                    <option value="${team}" ${selectedTeam == team ? 'selected' : ''}>${team}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    
    <c:choose>
        <c:when test="${fn:length(highlights) > 0}">
            <div class="highlight-grid">
                <c:forEach var="highlight" items="${highlights}">
                    <div class="highlight-card">
                        <div class="video-container">
                            <iframe 
                                src="${highlight.youtubeUrl}" 
                                title="${highlight.title}"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                allowfullscreen>
                            </iframe>
                        </div>
                        <div class="highlight-info">
                            <div class="highlight-title">${highlight.title}</div>
                            <div class="highlight-meta">
                                <span class="team-vs">${highlight.awayTeam} vs ${highlight.homeTeam}</span>
                                <span>${highlight.gameDate}</span>
                            </div>
                            <c:if test="${not empty highlight.description}">
                                <div class="highlight-description">${highlight.description}</div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-highlights">
                <h3>오늘의 하이라이트가 없습니다</h3>
                <p>경기 하이라이트가 업로드되면 여기에 표시됩니다.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="common/footer.jsp"/>

<script>
    function filterByTeam() {
        const teamSelect = document.getElementById('teamSelect');
        const selectedTeam = teamSelect.value;
        
        if (selectedTeam) {
            window.location.href = '/highlights?team=' + encodeURIComponent(selectedTeam);
        } else {
            window.location.href = '/highlights';
        }
    }
</script>

</body>
</html>

