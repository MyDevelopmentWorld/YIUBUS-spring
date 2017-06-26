<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="/cambus/ybus/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=ffea7e0f083460826a58d4a5fe3bf868"></script>
<link rel="stylesheet" href="/cambus/ybus/css/busStop.css">
<title>Cambus</title>
<!-- ����Ͽ��� -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />

<meta name="mobile-web-app-capable" content="yes">

<script src="/cambus/ybus/js/tabMenu.js"></script>

<!-- ico ������-->
<link rel="apple-touch-icon" href="/mobile/images/favicon.ico">
<style type="text/css">
#roadview{
	position:relative;
	width:75%;
	height:400px;
	margin:0 auto;
} 

</style>
</head>
<body>

	<div id="container">

		<div id="headArea">
			${bsRoadviewList.bsname} <img src="/cambus/ybus/images/busStop/topLogo.png" style="position: absolute; right: 0;height:100%;width:auto;" />
			<input type="button" value="<" style="color:white;position: absolute; font-size:1.5em;left: 3%;margin-top:1.5%; width: 8%; height: 50%;  background-color: transparent !important; border-color: transparent;"	onclick="history.go(-1);" />
		</div>

		<div id="contents">
			�̹����� �ƴմϴ�! ������ ���캸����~
			<div id="roadview"></div>
    	</div>
   	</div>

<input id="bslat" type=hidden value="${bsRoadviewList.bslat}">
<input id="bslng" type=hidden value="${bsRoadviewList.bslng}">
<input id="panoid" type=hidden value="${bsRoadviewList.panoid}">
<input id="pan" type=hidden value="${fn:split(bsRoadviewList.viewpoint,'#')[0]}">
<input id="tilt" type=hidden value="${fn:split(bsRoadviewList.viewpoint,'#')[1]}">
<input id="zoom" type=hidden value="${fn:split(bsRoadviewList.viewpoint,'#')[2]}">
<input id="marker" type=hidden value="${bsRoadviewList.marker}">
<input id="mlat" type=hidden value="${bsRoadviewList.mlat}">
<input id="mlng" type=hidden value="${bsRoadviewList.mlng}">

<script type="text/javascript">

//�ε�並 ǥ���� div
var roadviewContainer = document.getElementById('roadview'); 
var roadview = new daum.maps.Roadview(roadviewContainer);

roadview.setPanoId($("#panoid").val(), new daum.maps.LatLng($("#bslat").val(),$("#bslng").val()));
roadview.setViewpoint({pan:$("#pan").val() ,tilt:$("#tilt").val() ,zoom:$("#zoom").val() });

// ��Ŀ �̹����� �ּ�
var markerImageUrl = '/cambus/ybus/images/bus.png', 
    markerImageSize = new daum.maps.Size(100, 122), // ��Ŀ �̹����� ũ��
    markerImageOptions = { 
        offset : new daum.maps.Point(20, 42)// ��Ŀ ��ǥ�� ��ġ��ų �̹��� ���� ��ǥ
    };

// ��Ŀ �̹����� �����Ѵ�
var markerImage = new daum.maps.MarkerImage(markerImageUrl, markerImageSize, markerImageOptions);

daum.maps.event.addListener(roadview, 'init', function(){
	var marker = new daum.maps.Marker({
		
		position: new daum.maps.LatLng($("#mlat").val(), $("#mlng").val()), // ��Ŀ�� ��ǥ
	    image : markerImage, // ��Ŀ�� �̹���
	    map: roadview // ��Ŀ�� ǥ���� ���� ��ü
		
	});
});
</script>
</body>
</html>