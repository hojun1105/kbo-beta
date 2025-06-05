<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - KBO 팬 허브</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            color: #222;
        }
        .container {
            max-width: 700px;
            margin: 60px auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        h2 {
            margin-bottom: 30px;
            color: #c30452;
        }
        .info-row {
            margin-bottom: 20px;
        }
        .info-label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
        }
        input {
            padding: 8px;
            width: 300px;
            font-size: 14px;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 14px;
            background-color: #0457a9;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0062c6;
        }
        .btn-danger {
            background-color: #c30452;
        }
        .btn-danger:hover {
            background-color: #a00245;
        }
        .note {
            font-size: 12px;
            color: gray;
            margin-top: -10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>마이페이지</h2>

    <form id="userForm" action="/updateUser" method="post">
        <div class="info-row">
            <label class="info-label">아이디:</label>
            <input type="text" name="userId" value="${user.userId}" readonly>
        </div>

        <div class="info-row">
            <label class="info-label">닉네임:</label>
            <input type="text" id="nickname" name="nickname" value="${user.nickname}" readonly>
        </div>

        <div class="info-row">
            <label class="info-label">이메일:</label>
            <input type="email" id="email" name="email" value="${user.email}" readonly>
        </div>

        <div class="info-row">
            <label class="info-label">인스타그램:</label>
            <input type="text" id="instagram" name="instagram" value="${user.instagramId}" readonly placeholder="@yourid">
        </div>

        <button type="button" id="editBtn" class="btn" onclick="toggleEdit()">정보 수정</button>
    </form>

    <br><br>
    <form action="deleteUser.jsp" method="get">
        <button type="submit" class="btn btn-danger">회원 탈퇴</button>
    </form>
</div>

<script>
    let isEditable = false;

    function toggleEdit() {
        const fields = ['nickname', 'email', 'instagram'];
        fields.forEach(id => {
            document.getElementById(id).readOnly = !isEditable;
        });

        const btn = document.getElementById("editBtn");

        if (!isEditable) {
            btn.textContent = "수정 완료";
            isEditable = true;
        } else {
            document.getElementById("userForm").submit();
        }
    }
</script>
</body>
</html>
