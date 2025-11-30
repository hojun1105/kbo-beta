<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>경기장 주변 음식점 - KBO 팬 허브</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <jsp:include page="common/styles.jsp"/>
    <style>
        .restaurants-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .restaurants-section {
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

        .location-selector {
            margin-bottom: 24px;
        }

        .location-selector select {
            width: 100%;
            max-width: 400px;
            padding: 12px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            background: #fbfcfd;
            font-size: 15px;
            font-weight: 600;
            color: #1e3c72;
            cursor: pointer;
            outline: none;
        }

        .location-selector select:hover {
            border-color: #1e3c72;
        }

        .restaurant-card {
            border: 1px solid #f1f3f5;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            background: #fbfcfd;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .restaurant-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .restaurant-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }

        .restaurant-name {
            font-size: 18px;
            font-weight: 700;
            color: #1e3c72;
            margin: 0;
        }

        .store-reviews {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #555;
            font-size: 14px;
        }

        .restaurant-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            color: #555;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .restaurant-meta span {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .restaurant-description {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
            margin-top: 10px;
        }

        .restaurant-actions {
            margin-top: 14px;
            display: flex;
            gap: 10px;
        }

        .btn {
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-map {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
        }

        .btn-map:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(30, 60, 114, 0.3);
        }

        .empty-state {
            text-align: center;
            padding: 48px 0;
            color: #7b8a99;
            font-size: 16px;
        }

        .map-container {
            margin-top: 30px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        #naverMap {
            width: 100%;
            height: 400px;
        }

        .map-placeholder {
            width: 100%;
            height: 400px;
            background: #f1f3f5;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #868e96;
            font-size: 16px;
            border-radius: 12px;
        }
    </style>
    <script>
        const contextPath = '${pageContext.request.contextPath}';
        const stores = [
            <c:forEach var="store" items="${stores}" varStatus="status">
            {
                id: ${store.id},
                name: "<c:out value='${store.name}'/>",
                location: "<c:out value='${store.location}'/>",
                address: "<c:out value='${store.address}'/>",
                latitude: ${store.latitude != null ? store.latitude : 'null'},
                longitude: ${store.longitude != null ? store.longitude : 'null'},
                category: "<c:out value='${store.category}'/>",
                phoneNum: "<c:out value='${store.phoneNum}'/>",
                operatingHours: "<c:out value='${store.operatingHours}'/>",
                visitorReviews: "<c:out value='${store.visitorReviews}'/>",
                blogReviews: "<c:out value='${store.blogReviews}'/>",
                naverPlaceId: "<c:out value='${store.naverPlaceId}'/>"
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        const selectedLocation = "<c:out value='${selectedLocation}'/>";
    </script>
    <!-- 네이버 지도 API 스크립트 (향후 사용) -->
    <!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=YOUR_CLIENT_ID"></script> -->
</head>
<body>
<jsp:include page="common/header.jsp">
    <jsp:param name="activePage" value="restaurants"/>
</jsp:include>

<div class="restaurants-container">
    <div class="restaurants-section">
        <div class="section-title">
            <h2>경기장 주변 추천 음식점</h2>
        </div>

        <div class="location-selector">
            <form method="get" action="${pageContext.request.contextPath}/restaurants" id="locationForm">
                <select id="locationSelect" name="location" onchange="this.form.submit()">
                    <c:forEach var="location" items="${locations}">
                        <option value="<c:out value='${location}'/>" <c:if test="${location eq selectedLocation}">selected</c:if>>
                            <c:out value="${location}"/>
                        </option>
                    </c:forEach>
                </select>
            </form>
        </div>

        <div id="storeList">
            <c:choose>
                <c:when test="${empty stores}">
                    <div class="empty-state">해당 경기장 주변의 등록된 음식점이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="store" items="${stores}">
                        <div class="restaurant-card">
                            <div class="restaurant-header">
                                <h3 class="restaurant-name">
                                    <c:out value="${store.name}"/>
                                    <c:if test="${not empty store.category}">
                                        <span style="font-size: 14px; color: #868e96; font-weight: 400; margin-left: 8px;">
                                            (<c:out value="${store.category}"/>)
                                        </span>
                                    </c:if>
                                </h3>
                                <c:if test="${not empty store.visitorReviews || not empty store.blogReviews}">
                                    <div class="store-reviews">
                                        <c:if test="${not empty store.visitorReviews}">
                                            <span>👥 방문자 리뷰: <c:out value="${store.visitorReviews}"/></span>
                                        </c:if>
                                        <c:if test="${not empty store.blogReviews}">
                                            <span>📝 블로그 리뷰: <c:out value="${store.blogReviews}"/></span>
                                        </c:if>
                                    </div>
                                </c:if>
                            </div>
                            <div class="restaurant-meta">
                                <c:if test="${not empty store.address}">
                                    <span>📍 <c:out value="${store.address}"/></span>
                                </c:if>
                                <c:if test="${not empty store.phoneNum}">
                                    <span>📞 <c:out value="${store.phoneNum}"/></span>
                                </c:if>
                                <c:if test="${not empty store.operatingHours}">
                                    <span>🕐 <c:out value="${store.operatingHours}"/></span>
                                </c:if>
                            </div>
                            <div class="restaurant-actions">
                                <c:if test="${store.latitude != null && store.longitude != null}">
                                    <button class="btn btn-map" onclick="showOnMap(${store.latitude}, ${store.longitude}, '<c:out value="${store.name}"/>')">
                                        지도에서 보기
                                    </button>
                                </c:if>
                                <c:if test="${not empty store.naverPlaceId}">
                                    <button class="btn btn-map" onclick="openNaverPlace('${store.naverPlaceId}')">
                                        네이버 플레이스
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 네이버 지도 컨테이너 (향후 활성화) -->
        <div class="map-container" id="mapContainer" style="display: none;">
            <div id="naverMap" class="map-placeholder">
                네이버 지도 API 연동 준비 중입니다.
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>

<script>
    // changeLocation 함수는 더 이상 필요 없음 (form submit 사용)

    function showOnMap(latitude, longitude, name) {
        // 향후 네이버 지도 API 연동 시 사용
        alert('지도 기능은 네이버 지도 API 연동 후 사용 가능합니다.\n위치: ' + name + '\n위도: ' + latitude + ', 경도: ' + longitude);
        
        // 네이버 지도 API 연동 예시 코드 (주석 처리)
        /*
        if (typeof naver !== 'undefined' && naver.maps) {
            const mapContainer = document.getElementById('mapContainer');
            mapContainer.style.display = 'block';
            
            const mapOptions = {
                center: new naver.maps.LatLng(latitude, longitude),
                zoom: 15
            };
            
            const map = new naver.maps.Map('naverMap', mapOptions);
            
            const marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(latitude, longitude),
                map: map,
                title: name
            });
            
            const infoWindow = new naver.maps.InfoWindow({
                content: '<div style="padding: 10px;"><strong>' + name + '</strong></div>'
            });
            
            naver.maps.Event.addListener(marker, 'click', function() {
                infoWindow.open(map, marker);
            });
        }
        */
    }

    function openNaverPlace(placeId) {
        if (placeId) {
            // 네이버 플레이스 URL 형식 (실제 형식은 네이버 API 문서 참조)
            window.open('https://place.naver.com/place/' + placeId, '_blank');
        } else {
            alert('네이버 플레이스 ID가 없습니다.');
        }
    }
</script>
</body>
</html>

