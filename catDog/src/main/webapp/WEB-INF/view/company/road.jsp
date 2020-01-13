<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60c1097ba8f6f767297a53630f9853eb&libraries=services"></script>
<script>
$(function(){
	var addr = "서울 마포구 월드컵북로 21 2층 풍성빌딩";
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div태그
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), 
        level: 4
};  
	
var map = new kakao.maps.Map(mapContainer, mapOption); 

var geocoder = new kakao.maps.services.Geocoder();

geocoder.addressSearch(addr, function(result, status) {

     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">서울특별시 마포구 <br>월드컵북로 21 풍성빌딩 2층 멍냥개냥 사무실</div>'
        });
        infowindow.open(map, marker);

        map.setCenter(coords);
    } 
});    
	
});
</script>
<div align="center"><h2> </h2></div>

<div id="map" style="width: 900px; height: 500px; margin: 0px auto;"></div>
				
				
				