<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - KBO 팬 허브</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: linear-gradient(135deg, #0a0a23 0%, #1a1a3e 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #fff;
            padding: 20px;
        }

        .logo-container {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo-img {
            height: 70px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        
        .logo-img:hover {
            transform: scale(1.05);
        }

        .logo-container h1 {
            font-size: 1.5em;
            color: #fff;
            margin-bottom: 8px;
        }

        .logo-container p {
            color: #bbb;
            font-size: 0.85em;
        }

        .signup-container {
            background: white;
            padding: 35px 45px;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 440px;
        }

        .signup-container h2 {
            color: #0a0a23;
            text-align: center;
            margin-bottom: 25px;
            font-size: 1.4em;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 6px;
            font-size: 0.85em;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.9em;
            transition: all 0.3s ease;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .form-group input:focus {
            outline: none;
            border-color: #c30452;
            box-shadow: 0 0 0 3px rgba(195, 4, 82, 0.1);
        }

        .error-message {
            background-color: #ffe6e6;
            color: #c30452;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 0.9em;
            border: 1px solid #ffcccc;
        }

        .btn-signup {
            width: 100%;
            padding: 12px;
            background-color: #c30452;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 0.95em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 8px;
        }

        .btn-signup:hover {
            background-color: #a00342;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(195, 4, 82, 0.3);
        }

        .btn-signup:active {
            transform: translateY(0);
        }

        .links {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }

        .links a {
            color: #c30452;
            text-decoration: none;
            font-weight: 600;
            margin: 0 10px;
            font-size: 0.9em;
            transition: color 0.3s ease;
        }

        .links a:hover {
            color: #a00342;
            text-decoration: underline;
        }

        .links span {
            color: #999;
        }

        .helper-text {
            font-size: 0.75em;
            color: #666;
            margin-top: 3px;
        }
    </style>
</head>
<body>
    <div class="logo-container">
        <a href="<c:url value='/'/>">
            <img src="${pageContext.request.contextPath}/images/kbo.png" alt="KBO 팬 허브 로고" class="logo-img">
        </a>
        <h1>KBO 팬 허브</h1>
        <p>야구를 사랑하는 모든 팬들을 위한 공간</p>
    </div>

    <div class="signup-container">
        <h2>회원가입</h2>
        
        <c:if test="${param.error == '1'}">
            <div class="error-message">
                회원가입에 실패했습니다. 이미 존재하는 아이디이거나 입력 정보를 확인해주세요.
            </div>
        </c:if>

        <form action="<c:url value='/signup'/>" method="post">
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" required autofocus>
                <div class="helper-text">다른 사용자에게 표시될 이름입니다.</div>
            </div>

            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required>
                <div class="helper-text">로그인에 사용할 아이디입니다.</div>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>
                <div class="helper-text">비밀번호 찾기 등에 사용됩니다.</div>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
                <div class="helper-text">안전한 비밀번호를 사용해주세요.</div>
            </div>

            <button type="submit" class="btn-signup">회원가입</button>
        </form>

        <div class="links">
            <a href="<c:url value='/'/>">메인으로</a>
            <span>|</span>
            <a href="<c:url value='/login'/>">로그인</a>
        </div>
    </div>
</body>
</html>

