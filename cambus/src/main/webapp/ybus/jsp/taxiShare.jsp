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
	    alert("�� �������� Geolocation�� �������� �ʽ��ϴ�");
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
	  	point : oPoint, // ���� �߽����� ��ǥ
	  	zoom : 9, // ������ ��ô ����
	  	//boundary : Array // ���� ���� �� �־��� array �� �ִ� ���� ��� ���� �� �ֵ��� ������ �ʱ�ȭ�Ѵ�.
	  	//boundaryOffset : Number // boundary�� ������ �ʱ�ȭ �� �� ���� ��ü���� ���ܵǴ� ������ ũ��.
	  	enableWheelZoom : true, // ���콺 �� �������� ������ Ȯ��/������� ����
	  	enableDragPan : true, // ���콺�� ��� ������ �̵����� ����
	  	enableDblClickZoom : true, // ����Ŭ������ ������ Ȯ������ ����
	  	mapMode : 0, // ���� ���(0 : �Ϲ� ����, 1 : ��ħ ����, 2 : ���� ����)
	  	//activateTrafficMap : true, // �ǽð� ���� Ȱ��ȭ ����
	  	//activateBicycleMap : true, // ������ ���� Ȱ��ȭ ����
	  	minMaxLevel : [1, 14], // ������ �ּ�/�ִ� ��ô ����
	  	size : new nhn.api.map.Size(400, 250) // ������ ũ��
	  	//detectCoveredMarker : Boolean // ���� �ִ� ��Ŀ�� Ŭ������ �� ��ģ ��Ŀ ��� ǥ�� ����
	  });

	  var mapZoom = new nhn.api.map.ZoomControl(); // - �� ��Ʈ�� ����
	  mapZoom.setPosition({left:10, top:10});
	  oMap.addControl(mapZoom);
	  /* default map �� */
	   
	   /* ��Ŀǥ�� */
	  var sPoint = [];
	  var sMarker = []; //������ ��ġ,��Ŀ
	  var sSize = new nhn.api.map.Size(30, 30);
	  var sOffset = new nhn.api.map.Size(14, 37);
	  var sIcon = new nhn.api.map.Icon('/cambus/ybus/images/icon.png', sSize, sOffset);
	  sMarker[0] = new nhn.api.map.Marker(sIcon, { title : '' });
	  sPoint[0] = new nhn.api.map.LatLng(lat,lng);
	  sMarker[0].setPoint(sPoint[0]);
	  oMap.addOverlay(sMarker[0]);
	}
/* ��ġ �������� ��*/

/* ------------------------------------------------------------------------------------------- */
</script>
</html>