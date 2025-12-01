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
            max-width: 1400px;
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

        .map-container {
            margin-top: 20px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            height: 600px;
        }

        #naverMap {
            width: 100%;
            height: 100%;
        }

        .empty-state {
            text-align: center;
            padding: 48px 0;
            color: #7b8a99;
            font-size: 16px;
            height: 600px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .info-window {
            padding: 10px;
            min-width: 200px;
        }

        .info-window h4 {
            margin: 0 0 8px 0;
            color: #1e3c72;
            font-size: 16px;
        }

        .info-window p {
            margin: 4px 0;
            font-size: 13px;
            color: #555;
        }

        .info-window a {
            color: #1e3c72;
            text-decoration: none;
        }

        .info-window a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        const contextPath = '${pageContext.request.contextPath}';
        const stores = ${storesJson};
        const selectedLocation = "<c:out value='${selectedLocation}'/>";
        
        // 디버깅용
        console.log('전체 stores 배열:', stores);
        console.log('stores 개수:', stores ? stores.length : 0);
        if (stores && stores.length > 0) {
            console.log('첫 번째 store:', stores[0]);
        }
    </script>
    <!-- 네이버 지도 API 스크립트 -->
    <c:if test="${not empty naverMapClientId}">
        <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=${naverMapClientId}"
                onload="window.naverMapLoaded = true; if (window.initMapReady) initMap();" 
                onerror="console.error('네이버 지도 API 스크립트 로드 실패')"></script>
    </c:if>
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

        <!-- 네이버 지도 컨테이너 -->
        <div class="map-container">
            <c:choose>
                <c:when test="${empty stores}">
                    <div class="empty-state">해당 경기장 주변의 등록된 음식점이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <div id="naverMap"></div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>

<script>
    // 네이버 지도 초기화
    function initMap() {
        console.log('=== initMap 호출됨 ===');
        console.log('stores 배열:', stores);
        console.log('stores 개수:', stores ? stores.length : 0);
        
        const mapElement = document.getElementById('naverMap');
        if (!mapElement) {
            console.error('naverMap 요소를 찾을 수 없습니다.');
            return;
        }

        if (typeof naver === 'undefined' || !naver.maps) {
            console.error('네이버 지도 API를 불러올 수 없습니다. Client ID를 확인해주세요.');
            console.log('naver 객체:', typeof naver);
            mapElement.innerHTML = '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#868e96;flex-direction:column;"><p>네이버 지도 API를 불러올 수 없습니다.</p><p style="font-size:14px;margin-top:8px;">Client ID를 확인해주세요.</p></div>';
            return;
        }

        console.log('네이버 지도 API 로드 완료');

        // stores가 없거나 비어있는 경우
        if (!stores || stores.length === 0) {
            console.warn('stores 데이터가 없습니다.');
            mapElement.innerHTML = '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#868e96;flex-direction:column;"><p>표시할 음식점이 없습니다.</p><p style="font-size:14px;margin-top:8px;">해당 경기장에 등록된 음식점이 없습니다.</p></div>';
            return;
        }

        // 좌표가 있는 stores만 필터링
        const validStores = stores.filter(store => {
            const hasCoords = store.latitude != null && store.longitude != null;
            if (!hasCoords) {
                console.log('좌표 없는 store:', store.name, 'latitude:', store.latitude, 'longitude:', store.longitude);
            }
            return hasCoords;
        });
        console.log('유효한 stores 개수:', validStores.length);
        console.log('유효한 stores:', validStores);
        
        if (validStores.length === 0) {
            console.warn('좌표가 있는 음식점이 없습니다.');
            mapElement.innerHTML = '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#868e96;flex-direction:column;"><p>표시할 음식점이 없습니다.</p><p style="font-size:14px;margin-top:8px;">좌표 정보가 있는 음식점이 없습니다.</p></div>';
            return;
        }

        try {
            // 첫 번째 store의 위치를 중심으로 설정
            const firstStore = validStores[0];
            console.log('첫 번째 store:', firstStore);
            
            const mapOptions = {
                center: new naver.maps.LatLng(firstStore.latitude, firstStore.longitude),
                zoom: 14
            };

            const map = new naver.maps.Map('naverMap', mapOptions);
            console.log('지도 생성 완료');

        // 모든 stores에 마커 추가
        const markers = [];
        const infoWindows = [];

        validStores.forEach(function(store) {
            const position = new naver.maps.LatLng(store.latitude, store.longitude);
            
            // 마커 생성
            const marker = new naver.maps.Marker({
                position: position,
                map: map,
                title: store.name
            });

            // 정보창 내용 생성
            let infoContent = '<div class="info-window">';
            infoContent += '<h4>' + escapeHtml(store.name) + '</h4>';
            if (store.category) {
                infoContent += '<p><strong>카테고리:</strong> ' + escapeHtml(store.category) + '</p>';
            }
            if (store.address) {
                infoContent += '<p><strong>주소:</strong> ' + escapeHtml(store.address) + '</p>';
            }
            if (store.phoneNum) {
                infoContent += '<p><strong>전화:</strong> ' + escapeHtml(store.phoneNum) + '</p>';
            }
            if (store.operatingHours) {
                const hoursId = 'hours-' + store.id;
                infoContent += '<div style="margin: 6px 0;">';
                infoContent += '<strong style="cursor: pointer; font-size: 12px; color: #1e3c72; user-select: none;" onclick="toggleHours(\'' + hoursId + '\', this)">영업시간 ▼</strong>';
                infoContent += '<div id="' + hoursId + '" style="display: none; font-size: 11px; color: #666; margin-top: 4px; padding: 6px; background: #f5f5f5; border-radius: 4px; line-height: 1.4; white-space: pre-line;">';
                infoContent += escapeHtml(store.operatingHours);
                infoContent += '</div></div>';
            }
            if (store.visitorReviews || store.blogReviews) {
                infoContent += '<p>';
                if (store.visitorReviews) {
                    infoContent += '👥 ' + escapeHtml(store.visitorReviews);
                }
                if (store.blogReviews) {
                    if (store.visitorReviews) infoContent += ' | ';
                    infoContent += '📝 ' + escapeHtml(store.blogReviews);
                }
                infoContent += '</p>';
            }
            if (store.naverPlaceId) {
                infoContent += '<p><a href="https://place.naver.com/place/' + store.naverPlaceId + '" target="_blank">네이버 플레이스 보기 →</a></p>';
            }
            infoContent += '</div>';

            const infoWindow = new naver.maps.InfoWindow({
                content: infoContent
            });

            markers.push(marker);
            infoWindows.push(infoWindow);

            // 마커 클릭 시 정보창 표시
            naver.maps.Event.addListener(marker, 'click', function() {
                // 다른 정보창 닫기
                infoWindows.forEach(function(iw) {
                    iw.close();
                });
                infoWindow.open(map, marker);
            });
        });

        // 모든 마커가 보이도록 지도 범위 조정
        if (validStores.length > 1) {
            const bounds = new naver.maps.LatLngBounds();
            validStores.forEach(function(store) {
                bounds.extend(new naver.maps.LatLng(store.latitude, store.longitude));
            });
            map.fitBounds(bounds);
            }
            
            console.log('마커 개수:', markers.length);
        } catch (error) {
            console.error('지도 초기화 중 오류 발생:', error);
            mapElement.innerHTML = '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#868e96;flex-direction:column;"><p>지도 초기화 중 오류가 발생했습니다.</p><p style="font-size:14px;margin-top:8px;">' + error.message + '</p></div>';
        }
    }

    function escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    function toggleHours(id, element) {
        const el = document.getElementById(id);
        if (el) {
            const isHidden = el.style.display === 'none';
            el.style.display = isHidden ? 'block' : 'none';
            if (element) {
                element.innerHTML = '영업시간 ' + (isHidden ? '▲' : '▼');
            }
        }
    }

    // 스크립트 로드 확인 후 초기화
    function waitForNaverMap() {
        if (typeof naver !== 'undefined' && naver.maps) {
            initMap();
        } else if (window.naverMapLoaded) {
            // 스크립트는 로드되었지만 naver 객체가 아직 준비되지 않음
            setTimeout(waitForNaverMap, 100);
        } else {
            // 스크립트가 아직 로드되지 않음
            setTimeout(waitForNaverMap, 100);
        }
    }

    // 페이지 로드 시 지도 초기화
    window.addEventListener('load', function() {
        window.initMapReady = true;
        if (window.naverMapLoaded) {
            waitForNaverMap();
        } else {
            // 스크립트가 로드되지 않았으면 대기
            waitForNaverMap();
        }
    });
</script>
</body>
</html>
