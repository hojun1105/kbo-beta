<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>티켓팅 - KBO 팬 허브</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <jsp:include page="common/styles.jsp"/>
    <style>
        .ticketing-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .ticketing-section {
            background: white;
            border-radius: 16px;
            padding: 24px 28px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.06);
            margin-bottom: 30px;
        }

        .section-title {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
        }

        .section-title h2 {
            font-size: 22px;
            font-weight: 700;
            color: #1e3c72;
            margin: 0;
        }

        .game-card,
        .reservation-card {
            border: 1px solid #f1f3f5;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            background: #fbfcfd;
        }

        .game-card h3,
        .reservation-card h3 {
            font-size: 18px;
            font-weight: 700;
            color: #1e3c72;
            margin-bottom: 10px;
        }

        .meta-row {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            color: #555;
            font-size: 14px;
        }

        .meta-row span {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .action-row {
            margin-top: 16px;
        }

        .reserve-button {
            border: none;
            border-radius: 10px;
            padding: 10px 18px;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .reserve-button:hover {
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 48px 0;
            color: #7b8a99;
            font-size: 16px;
        }

        .login-required {
            text-align: center;
            padding: 40px;
            background: #f8f9fa;
            border-radius: 16px;
        }

        .login-required p {
            margin-bottom: 18px;
            color: #5b6776;
        }

        .login-required a {
            display: inline-block;
            background: linear-gradient(135deg, #ff6b35, #f7931e);
            color: white;
            padding: 12px 26px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="ticketing"/>
</jsp:include>

<div class="ticketing-container">
    <div class="ticketing-section">
        <div class="section-title">
            <h2>다가오는 경기</h2>
        </div>
        <div id="upcomingGames"></div>
    </div>

    <div class="ticketing-section">
        <div class="section-title">
            <h2>내 티켓</h2>
        </div>
        <c:choose>
            <c:when test="${empty currentUserId}">
                <div class="login-required">
                    <p>티켓을 확인하려면 로그인해주세요.</p>
                    <a href="<c:url value='/login'/>">로그인 하러 가기</a>
                </div>
            </c:when>
            <c:otherwise>
                <div id="reservationList"></div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>

<script>
    const loggedIn = ${empty currentUserId ? "false" : "true"};
    const contextPath = '${pageContext.request.contextPath}';

    function escapeHtml(value) {
        if (value === null || value === undefined) {
            return '';
        }
        return String(value).replace(/[&<>"']/g, function (char) {
            switch (char) {
                case '&': return '&amp;';
                case '<': return '&lt;';
                case '>': return '&gt;';
                case '"': return '&quot;';
                case '\'': return '&#39;';
                default: return char;
            }
        });
    }

    function formatDateTime(dateObj) {
        if (!dateObj) {
            return '미정';
        }

        if (Array.isArray(dateObj)) {
            const year = dateObj[0];
            const month = String(dateObj[1]).padStart(2, '0');
            const day = String(dateObj[2]).padStart(2, '0');
            const hour = String(dateObj[3] || 0).padStart(2, '0');
            const minute = String(dateObj[4] || 0).padStart(2, '0');
            return year + '년 ' + month + '월 ' + day + '일 ' + hour + ':' + minute;
        }

        if (typeof dateObj === 'object' && dateObj.year) {
            const year = dateObj.year;
            const month = String(dateObj.monthValue || dateObj.month || 0).padStart(2, '0');
            const day = String(dateObj.dayOfMonth || dateObj.day || 0).padStart(2, '0');
            const hour = String(dateObj.hour || 0).padStart(2, '0');
            const minute = String(dateObj.minute || 0).padStart(2, '0');
            return year + '년 ' + month + '월 ' + day + '일 ' + hour + ':' + minute;
        }

        if (typeof dateObj === 'string') {
            try {
                const date = new Date(dateObj);
                if (!isNaN(date.getTime())) {
                    const month = String(date.getMonth() + 1).padStart(2, '0');
                    const day = String(date.getDate()).padStart(2, '0');
                    const hour = String(date.getHours()).padStart(2, '0');
                    const minute = String(date.getMinutes()).padStart(2, '0');
                    return date.getFullYear() + '년 ' + month + '월 ' + day + '일 ' + hour + ':' + minute;
                }
            } catch (e) {
                return '미정';
            }
        }

        return '미정';
    }

    function renderUpcomingGames(games) {
        const container = document.getElementById('upcomingGames');
        if (!games || games.length === 0) {
            container.innerHTML = '<div class="empty-state">예정된 경기가 없습니다.</div>';
            return;
        }

        const cards = games.map(function (game) {
            const weatherHtml = game.weather ? '<span>🌤️ ' + escapeHtml(game.weather) + '</span>' : '';
            let actionHtml = '';
            if (loggedIn) {
                const home = "'" + escapeHtml(game.homeTeam || '') + "'";
                const away = "'" + escapeHtml(game.awayTeam || '') + "'";
                actionHtml =
                    '<div class="action-row">' +
                        '<button class="reserve-button" onclick="openReservationDialog(' + game.id + ', ' + home + ', ' + away + ')">' +
                            '좌석 예약' +
                        '</button>' +
                    '</div>';
            }

            return (
                '<div class="game-card">' +
                    '<h3>' + escapeHtml(game.homeTeam) + ' vs ' + escapeHtml(game.awayTeam) + '</h3>' +
                    '<div class="meta-row">' +
                        '<span>📅 ' + formatDateTime(game.gameDate) + '</span>' +
                        '<span>📍 ' + escapeHtml(game.stadium) + '</span>' +
                        weatherHtml +
                    '</div>' +
                    actionHtml +
                '</div>'
            );
        }).join('');

        container.innerHTML = cards;
    }

    function renderReservations(reservations) {
        const container = document.getElementById('reservationList');
        if (!container) {
            return;
        }

        if (!reservations || reservations.length === 0) {
            container.innerHTML = '<div class="empty-state">아직 예약한 티켓이 없습니다.</div>';
            return;
        }

        const cards = reservations.map(function (item) {
            const descriptionHtml = item.description
                ? '<p style="margin-top: 14px; color: #556; font-size: 14px;">메모: ' + escapeHtml(item.description) + '</p>'
                : '';

            const actionHtml = item.status === 'RESERVED'
                ? '<div class="action-row">' +
                    '<button class="reserve-button" style="background: #e03131" onclick="cancelReservation(' + item.id + ')">' +
                        '예약 취소' +
                    '</button>' +
                  '</div>'
                : '';

            return (
                '<div class="reservation-card">' +
                    '<h3>' + escapeHtml(item.homeTeam) + ' vs ' + escapeHtml(item.awayTeam) + '</h3>' +
                    '<div class="meta-row">' +
                        '<span>📅 ' + formatDateTime(item.gameDate) + '</span>' +
                        '<span>📍 ' + escapeHtml(item.stadium) + '</span>' +
                        '<span>🎫 ' + escapeHtml(item.seatSection) + ' ' + escapeHtml(item.seatRow) + '열 ' + escapeHtml(item.seatNumber) + '번</span>' +
                        '<span>📌 상태: ' + escapeHtml(item.status) + '</span>' +
                    '</div>' +
                    descriptionHtml +
                    actionHtml +
                '</div>'
            );
        }).join('');

        container.innerHTML = cards;
    }

    async function fetchUpcomingGames() {
        try {
            const response = await fetch(contextPath + '/api/ticketing/games/upcoming');
            const data = await response.json();
            renderUpcomingGames(data);
        } catch (error) {
            console.error('다가오는 경기 조회 실패', error);
            document.getElementById('upcomingGames').innerHTML = '<div class="empty-state">경기 정보를 불러오지 못했습니다.</div>';
        }
    }

    async function fetchMyReservations() {
        if (!loggedIn) {
            return;
        }

        try {
            const response = await fetch(contextPath + '/api/ticketing/reservations/my', {
                headers: {
                    'Accept': 'application/json'
                }
            });
            if (response.status === 401) {
                document.getElementById('reservationList').innerHTML = '<div class="empty-state">세션이 만료되었습니다. 다시 로그인해주세요.</div>';
                return;
            }
            const data = await response.json();
            renderReservations(data);
        } catch (error) {
            console.error('티켓 조회 실패', error);
            document.getElementById('reservationList').innerHTML = '<div class="empty-state">티켓 정보를 불러오지 못했습니다.</div>';
        }
    }

    function openReservationDialog(gameId, homeTeam, awayTeam) {
        try {
            const base = (window.location && window.location.origin ? window.location.origin : '') + (contextPath || '');
            const url = base + '/ticketing/reserve?gameId=' + encodeURIComponent(gameId);
            window.location.assign(url);
        } catch (_e) {
            window.location.href = (contextPath || '') + '/ticketing/reserve?gameId=' + gameId;
        }
    }

    async function reserveTicket(gameId, seatSection, seatRow, seatNumber, description) {
        try {
            const response = await fetch(contextPath + '/api/ticketing/reservations', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    gameId: gameId,
                    seatSection: seatSection,
                    seatRow: seatRow,
                    seatNumber: seatNumber,
                    description: description
                })
            });

            if (response.status === 401) {
                alert('로그아웃되었습니다. 다시 로그인해주세요.');
                window.location.href = contextPath + '/login';
                return;
            }

            if (!response.ok) {
                const errorText = await response.text();
                alert('예약 실패: ' + errorText);
                return;
            }

            alert('티켓이 예약되었습니다.');
            fetchMyReservations();
            try {
                const listEl = document.getElementById('reservationList');
                if (listEl) {
                    listEl.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            } catch (_e) {}
        } catch (error) {
            console.error('예약 실패', error);
            alert('예약 중 오류가 발생했습니다.');
        }
    }

    async function cancelReservation(reservationId) {
        if (!confirm('정말로 이 예약을 취소하시겠습니까?')) {
            return;
        }

        try {
            const response = await fetch(contextPath + '/api/ticketing/reservations/' + reservationId, {
                method: 'DELETE'
            });

            if (response.status === 401) {
                alert('로그인 상태가 만료되었습니다. 다시 로그인해주세요.');
                window.location.href = contextPath + '/login';
                return;
            }

            if (!response.ok) {
                const errorText = await response.text();
                alert('취소 실패: ' + errorText);
                return;
            }

            alert('예약이 취소되었습니다.');
            fetchMyReservations();
        } catch (error) {
            console.error('취소 실패', error);
            alert('취소 중 오류가 발생했습니다.');
        }
    }

    fetchUpcomingGames();
    fetchMyReservations();
</script>
</body>
</html>

