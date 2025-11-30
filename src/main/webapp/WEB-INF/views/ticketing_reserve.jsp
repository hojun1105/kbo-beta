<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>티켓 예약 - KBO 팬 허브</title>
    <jsp:include page="common/styles.jsp"/>
    <style>
        .reserve-container { max-width: 720px; margin: 40px auto; padding: 0 20px; }
        .card { background: #fff; border-radius: 16px; padding: 24px 28px; box-shadow: 0 12px 30px rgba(0,0,0,0.06); }
        .title { font-size: 22px; font-weight: 700; color: #1e3c72; margin: 0 0 16px 0; }
        .meta { color: #556; margin-bottom: 18px; }
        .form-row { display: flex; gap: 12px; margin-bottom: 12px; }
        .form-row > div { flex: 1; }
        label { display: block; font-weight: 600; color: #334; margin-bottom: 6px; }
        input[type="text"], textarea {
            width: 100%; padding: 10px 12px; border: 1px solid #e2e8f0; border-radius: 10px;
            background: #fbfcfd; font-size: 14px; outline: none;
        }
        textarea { min-height: 90px; resize: vertical; }
        .actions { margin-top: 16px; display: flex; gap: 10px; }
        .btn {
            border: none; border-radius: 10px; padding: 10px 18px; color: #fff; font-weight: 600; cursor: pointer;
        }
        .btn-primary { background: linear-gradient(135deg, #1e3c72, #2a5298); }
        .btn-secondary { background: #868e96; }
    </style>
    <script>
        const contextPath = '${pageContext.request.contextPath}';

        const game = {
            id: ${game.id},
            homeTeam: "<c:out value='${game.homeTeam}' default='?'></c:out>",
            awayTeam: "<c:out value='${game.awayTeam}' default='?'></c:out>",
            stadium: "<c:out value='${game.stadium}' default='?'></c:out>"
        };
    </script>
</head>
<body>
<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="ticketing"/>
</jsp:include>

<div class="reserve-container">
    <div class="card">
        <h1 class="title">티켓 예약</h1>
        <div class="meta">
            <div><strong>경기</strong>: <c:out value="${game.homeTeam}"/> vs <c:out value="${game.awayTeam}"/></div>
            <div><strong>구장</strong>: <c:out value="${game.stadium}"/></div>
        </div>

        <form id="reserveForm" onsubmit="submitReservation(event)">
            <input type="hidden" id="gameId" value="${game.id}"/>
            <div class="form-row">
                <div>
                    <label for="seatSection">좌석 구역</label>
                    <input type="text" id="seatSection" placeholder="예: 1루" required />
                </div>
                <div>
                    <label for="seatRow">열</label>
                    <input type="text" id="seatRow" placeholder="예: 1" required />
                </div>
                <div>
                    <label for="seatNumber">좌석 번호</label>
                    <input type="text" id="seatNumber" placeholder="예: 10" required />
                </div>
            </div>
            <div>
                <label for="description">메모 (선택)</label>
                <textarea id="description" placeholder="기타 요청사항을 입력하세요."></textarea>
            </div>
            <div class="actions">
                <button type="submit" class="btn btn-primary">예약하기</button>
                <button type="button" class="btn btn-secondary" onclick="window.location.href = contextPath + '/ticketing'">취소</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>

<script>
    async function submitReservation(event) {
        event.preventDefault();
        const gameId = document.getElementById('gameId').value;
        const seatSection = document.getElementById('seatSection').value.trim();
        const seatRow = document.getElementById('seatRow').value.trim();
        const seatNumber = document.getElementById('seatNumber').value.trim();
        const description = document.getElementById('description').value.trim();

        if (!seatSection || !seatRow || !seatNumber) {
            alert('좌석 정보를 모두 입력해주세요.');
            return;
        }

        try {
            const response = await fetch(contextPath + '/api/ticketing/reservations', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ gameId, seatSection, seatRow, seatNumber, description })
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
            window.location.href = contextPath + '/ticketing';
        } catch (e) {
            console.error(e);
            alert('예약 중 오류가 발생했습니다.');
        }
    }
</script>
</body>
</html>


