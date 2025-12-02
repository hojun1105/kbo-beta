<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar">
    <div class="navbar-left">
        <a href="<c:url value="/"/>" class="navbar-brand">
            <img src="${pageContext.request.contextPath}/images/kbo.png" alt="KBO 팬 허브 로고" class="logo-img">
        </a>
        <div class="nav-group-left">
            <a href="<c:url value="/predict"/>" class="nav-link ${param.activePage == 'predict' ? 'active' : ''}">오늘의 경기</a>
            <c:if test="${isLoggedIn}">
                <a href="<c:url value="/record"/>" class="nav-link ${param.activePage == 'record' ? 'active' : ''}">자료실</a>
                <a href="<c:url value="/community"/>" class="nav-link ${param.activePage == 'community' ? 'active' : ''}">커뮤니티</a>
                <a href="<c:url value="/highlights"/>" class="nav-link ${param.activePage == 'highlights' ? 'active' : ''}">하이라이트</a>
                <a href="<c:url value="/ticketing"/>" class="nav-link ${param.activePage == 'ticketing' ? 'active' : ''}">티켓팅</a>
                <a href="<c:url value="/restaurants"/>" class="nav-link ${param.activePage == 'restaurants' ? 'active' : ''}">Eats</a>
            </c:if>
        </div>
    </div>
    <div class="nav-group-right">
        <c:choose>
            <c:when test="${isLoggedIn}">
                <a href="<c:url value="/userInfo"/>" class="nav-link">내 정보</a>
                <a href="/logout" class="nav-link">로그아웃</a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value="/login"/>" class="nav-link">로그인</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

