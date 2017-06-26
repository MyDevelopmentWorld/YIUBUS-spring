<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
</head>
<body onload="loadPost()">
<div class="view_map" id="map"></div>
</body>
<script type="text/javascript" src=" http://openapi.map.naver.com/openapi/v2/maps.js?clientId=yZLkZBpGBUq9DPcRUD8i"></script>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
 
<script type="text/javascript">
var lat;
var lng;

function loadPost() {
	  if (!!navigator.geolocation) 
	  {
	    navigator.geolocation.getCurrentPosition(successCallback,errorCallback);  
	  }
	  else
	  {
	    alert("이 브라우저는 Geolocation를 지원하지 않습니다");
	  }
	
	}    
	 
	function errorCallback(error)
	{
	    alert(error.message);
	}    
	 
	function successCallback(position) {
	  lat = position.coords.latitude;
	  lng = position.coords.longitude;
	  
	  console.log(lat+"    "+lng);
	  var oPoint = new nhn.api.map.LatLng(lat,lng);
	  var oMap = new nhn.api.map.Map("map", {
	  	point : oPoint, // 지도 중심점의 좌표
	  	zoom : 9, // 지도의 축척 레벨
	  	//boundary : Array // 지도 생성 시 주어진 array 에 있는 점이 모두 보일 수 있도록 지도를 초기화한다.
	  	//boundaryOffset : Number // boundary로 지도를 초기화 할 때 지도 전체에서 제외되는 영역의 크기.
	  	enableWheelZoom : true, // 마우스 휠 동작으로 지도를 확대/축소할지 여부
	  	enableDragPan : true, // 마우스로 끌어서 지도를 이동할지 여부
	  	enableDblClickZoom : true, // 더블클릭으로 지도를 확대할지 여부
	  	mapMode : 0, // 지도 모드(0 : 일반 지도, 1 : 겹침 지도, 2 : 위성 지도)
	  	//activateTrafficMap : true, // 실시간 교통 활성화 여부
	  	//activateBicycleMap : true, // 자전거 지도 활성화 여부
	  	minMaxLevel : [1, 14], // 지도의 최소/최대 축척 레벨
	  	size : new nhn.api.map.Size(400, 250) // 지도의 크기
	  	//detectCoveredMarker : Boolean // 겹쳐 있는 마커를 클릭했을 때 겹친 마커 목록 표시 여부
	  });

	  var mapZoom = new nhn.api.map.ZoomControl(); // - 줌 컨트롤 선언
	  mapZoom.setPosition({left:10, top:10});
	  oMap.addControl(mapZoom);
	  /* default map 끝 */
	   
	   /* 마커표시 */
	  var sPoint = [];
	  var sMarker = []; //정류장 위치,마커
	  var sSize = new nhn.api.map.Size(30, 30);
	  var sOffset = new nhn.api.map.Size(14, 37);
	  var sIcon = new nhn.api.map.Icon('/cambus/ybus/images/icon.png', sSize, sOffset);
	  sMarker[0] = new nhn.api.map.Marker(sIcon, { title : '' });
	  sPoint[0] = new nhn.api.map.LatLng(lat,lng);
	  sMarker[0].setPoint(sPoint[0]);
	  oMap.addOverlay(sMarker[0]);
	}
/* 위치 가져오기 끝*/

/* ------------------------------------------------------------------------------------------- */
</script>
</html>