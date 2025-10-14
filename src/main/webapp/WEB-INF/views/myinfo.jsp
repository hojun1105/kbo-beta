<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - KBO 팬 허브</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <jsp:include page="common/styles.jsp"/>
    <style>

        .container {
            max-width: 480px;
            margin: 120px auto;
            background: white;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.08);
        }

        .login-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .login-header h2 {
            margin: 0;
            font-size: 22px;
            color: black;
            line-height: 1;
        }

        .login-logo {
            height: 36px;
            cursor: pointer;
        }

        .info-row {
            margin-bottom: 18px;
        }

        .info-label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #333;
        }

        input {
            padding: 12px;
            width: 100%;
            font-size: 14px;
            box-sizing: border-box;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .btn {
            margin-top: 20px;
            padding: 12px 20px;
            font-size: 14px;
            background-color: #0457a9;
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 48%;
        }

        .btn:hover {
            background-color: #0062c6;
        }

        .btn.edit-active {
            background-color: #28a745 !important;
        }

        .btn-danger {
            background-color: #c30452;
        }

        .btn-danger:hover {
            background-color: #a00245;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp"/>

<div class="container">
    <div class="login-header">
        <h2>마이페이지</h2>
    </div>

    <form id="userForm" action="/updateUser" method="post">
        <div class="info-row">
            <label class="info-label">아이디</label>
            <input type="text" name="userId" value="${user.userId}" readonly>
        </div>

        <div class="info-row">
            <label class="info-label">닉네임</label>
            <input type="text" id="nickname" name="nickname" value="${user.nickname}" readonly>
        </div>

        <div class="info-row">
            <label class="info-label">이메일</label>
            <input type="email" id="email" name="email" value="${user.email}" readonly>
        </div>

        <div class="info-row">
            <label class="info-label">인스타그램</label>
            <input type="text" id="instagram" name="instagramId" value="${user.instagramId}" readonly placeholder="@yourid">
        </div>

        <div class="button-group">
            <button type="button" id="editBtn" class="btn" onclick="toggleEdit()">정보 수정</button>
            <button type="submit" formaction="/deleteUser" formmethod="get" class="btn btn-danger">회원 탈퇴</button>
        </div>
    </form>
</div>

<script>
    let isEditable = false;

    function toggleEdit() {
        const fields = ['nickname', 'email', 'instagram'];
        fields.forEach(id => {
            const input = document.getElementById(id);
            if (!isEditable) {
                input.removeAttribute("readonly");
            } else {
                input.setAttribute("readonly", "true");
            }
        });

        const btn = document.getElementById("editBtn");

        if (!isEditable) {
            btn.textContent = "수정 완료";
            btn.classList.add("edit-active");
            isEditable = true;
        } else {
            btn.classList.remove("edit-active");
            document.getElementById("userForm").submit();
        }
    }
</script>

<jsp:include page="common/footer.jsp"/>

</body>
</html>
