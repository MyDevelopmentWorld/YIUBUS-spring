<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cambus</title>


<!-- 모바일용웹 -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />

<meta name="mobile-web-app-capable" content="yes">




<!-- ico 아이콘-->
<link rel="apple-touch-icon" href="/cambus/ybus/images/ico/favicon.ico">

<style>
@font-face {
	font-family: "notoFont-medium";
	src: url(/cambus/ybus/fonts/NotoSansCJKkr-Medium.woff) format("truetype");
}

@font-face {
	font-family: "notoFont-bold";
	src: url(/cambus/ybus/fonts/NotoSansCJKsc-Bold.woff) format("truetype");
}

body, p, div, li, ul, span, img {
	margin: 0;
	padding: 0;
}

img {
	width: 60%;
	height: auto;
}

body, html {
	position: relative;
	width: 100%;
	max-width: 480px;
	height: 100%;
	font-family: 'notoFont-bold';
	color: #222;
	background-color: white;
	overflow-x: hidden;
	height: 100%;
	margin: 0 auto;
	/* -webkit-overflow-scrolling: touch; 터치부드럽게 상단고정해더가 늦게움직이는현상발생*/
}

#container {
	position: relative;
	width: 100%;
	max-width: 480px;
	height: 568px;
	margin: 0 auto;
	background-color: yellow;
}

#top {
	position: fixed;
	max-width: 480px;
	width: 100%;
	height: 25%;
	z-index: 3;
}

#header {
	position: relative;
	width: 100%;
	height: 50px;
	background-color: #003d4f;
	text-align: center;
	color: white;
	background-color: #003d4f;
}

#infoPage {
	position: relative;
	width: 100%;
	height: 100%;
	background-color: #003d4f;
}

#txtLogo {
	position: relative;
	width: 60%;
	height: 80%;
	padding-top: 4%;
	margin: 0 auto;
	font-weight: bold;
}

#logo {
	position: absolute;
	top: 0;
	right: 0;
	height: 100%;
	width: auto;
}

#btnArea {
	position: relative;
	width: 100%;
	height: 60px;
	background-color: #dfdfdf;
	padding-top: 30px;
}

#btnGroup {
	position: relative;
	width: 90%;
	height: 40px;
	margin: 0 auto;
	width: 90%;
}

.goBtn {
	width: 45%;
	height: 70%;
	margin: 0 auto;
	text-align: center;
	background-color: #ffffff;
	padding-top: 1.5%;
	color: black;
}

#upBtn {
	float: left;
	border-bottom: 5px solid #003d4f;
}

#downBtn {
	float: right;
	border-bottom: 5px solid #eb6100;
}

/* contents 부분 시작*/
#contents {
	position: relative;
	width: 100%;
	height: 90%;
	margin: 0;
	padding: 0;
	padding-top:55%;

	background-color: white;
}
/* 아이폰5 */
@media(max-width:320px) { 
 #contents{
 padding-top:65%;
 } 
}
/* 정류장 타임라인 틀 시작 */
#lineArea {
	position: relative;
	width: 100%;
	height: 100%;
}

.busStop {
	position: relative;
	width: 100%;
	height: 50px;
	background-color: white;
	border-bottom: 2px solid #b2b2b2;
}


/* 정류장 선 */
.way {
	position: relative;
	float: left;
	width: 35%;
	height: 100%;
}
/* 타임라인 시작 정류장  */
.startPoint {
	position: absolute;
	width: 100%;
	height: 100%;
}
/* 타임라인 마지막 정류장  */
.endPoint {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}
/* 상행선 화살표o */
.upLine {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}
/* 하행선 화살표 x */
.downLine {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}


#turnPoint {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}
.lineImg{
	width:auto;
	height:105%;
	float:right;
	margin-right:25%;
	z-index:10;
	
}



.stopName {
	
	float: left;
	width: 65%;
	height: 100%;
}

.txtName {
	margin-top: 6%;
}

/* 버스 아이콘 관련 시작 */
.busIcon {
	position: relative;
	width: 50%;
	height: 90%;
	float: left;
	padding-top:4%;
}

.busNum {
	position: relative;
	float: left;
	width: 50%;
	height: 90%;
	text-align: right;
	padding-top:4%;
	
}

.busTxt {
	position: absolute;
	width: 50%;
	height: 30%;
	font-size: 1.0em;
	padding-top: 20%;
	padding-left: 22px;
}

.infoDiv{
	position: absolute;
	width: 50%;
	height: 30%;
	font-size: 1.4em;
	padding-top: 10%;
}

#footer {
	position: relative;
	width: 95%;
	height: 40%;
	background-color: #bfbfbf;
	text-align: left;
	color: #272727;
	font-size: 0.5em;
	padding-left:5%;
}
#refreshBtn{
	position:absolute;
	 width:auto;
	 height:80%;
	 margin:0;
	 padding:0;
	 margin-right:5%;
	 top:10%;
	 right:0;
	 
}

#mapBtn{
	position:absolute;
	 width:auto;
	 height:80%;
	 margin:0;
	 padding:0;
	 margin-right:18%;
	 top:10%;
	 right:0;
	 
}
</style>
<script src="/cambus/ybus/js/jquery-1.12.4.js"></script>
<script>
	$(function(){
		
		//버스이미지 클릭시 총 몇대버스인지 확인창
		$("img[name='busIcon']").click(function(){
			alert($(this).prev().val());
			return false;
		});
		
	});
	
function goBsMap(){
	document.location.href = "/cambus/ybus/jsp/bsMap.jsp?line=yellow";
}	
</script>
</head>
<body>
	<div id="container">
		<div id="top">
			<div id="header">
				<div id="infoPage">
					<input type="button" value="<" style="color:white;position: absolute; font-size:1.5em;left: 3%;margin-top:1.5%; width: 8%; height: 50%;  background-color: transparent !important; border-color: transparent;"	onclick="history.go(-1);" />
					<div id="txtLogo">
					
					노랑버스 위치조회
					
					</div>
					<img src="/cambus/ybus/images/timeLine/header_logo.png" id="logo" />
				</div>
			</div>

			<div id="btnArea">
				<div id="btnGroup">
					<div id="upBtn" class="goBtn">터미널 방면</div>
					<div id="downBtn" class="goBtn">용인대 방면</div>
				</div>
			</div>
					<div id="footer">
					<div style= "position:relative;width:85%;height:100%;padding-top:3%;" class="infoDiv">
					● 버스아이콘 터치 -> 중복되는 버스 확인 <p>
					● 네이버 지도를 클릭 -> 지도로 확인
					</div>	
					<img src="/cambus/ybus/images/timeLine/refreshBtn.png" id="refreshBtn" onclick="location.reload(true);"/>
					<img src="/cambus/ybus/images/timeLine/navermap.png" id="mapBtn" onclick="goBsMap()"/>
					</div>
		</div>
		<div id="contents">
			<div id="lineArea">

<c:forEach var="i"  items="${timeLine}" varStatus="ct">

<c:choose>
	<c:when test="${ct.count eq '1' }">
		<c:set var="whatPoint" value="startPoint"></c:set>
		<c:set var="whatStopImg" value="/cambus/ybus/images/timeLine/startImg.png"></c:set>
	</c:when>
	
 	<c:when test="${ct.count eq fn:length(timeLine) }">
		<c:set var="whatPoint" value="endPoint"></c:set>
		<c:set var="whatStopImg" value="/cambus/ybus/images/timeLine/endImg2.png"></c:set>
	</c:when>
	
	
	<c:when test="${i.updown eq 'up'}">
		<c:set var="whatPoint" value="upLine"></c:set>
		<c:set var="whatStopImg" value="/cambus/ybus/images/timeLine/upImg.png"></c:set>
	</c:when>
	
	
	<c:otherwise>
		<c:set var="whatPoint" value="downLine"></c:set>
		<c:set var="whatStopImg" value="/cambus/ybus/images/timeLine/downImg.png"></c:set>
	</c:otherwise>
</c:choose>
				<!-- 정류장리스트 시작 -->
				<div class="busStop" id="busStop" name="busStop">
				<input type="hidden" value="${i.bsrpk}" />
					<div class="way" id="way1">
						<div class="${whatPoint }">
							<img src="${whatStopImg }" class="lineImg" />
						</div>
					
					<!-- 버스있을경우 -->
					<c:choose>
						<c:when test="${i.busid ne null}">
						
						<!-- 첫번째만 집어넣기위함 -->
						<c:set var="busid" value="${fn:split(i.busid,',')}" />
						
						<div class="busNum">
						<div class="busTxt">${busid[0]}</div>
						<!-- <img src="/cambus/ybus/images/timeLine/busNum.png" alt="" /> -->
						</div>
						
						<div class="busIcon">
							<input type="hidden" id="busids" value="${i.busid}" />
							<img name="busIcon" src="/cambus/ybus/images/timeLine/busIcon.png" alt="" />
						</div>
						</c:when>
					</c:choose>
					<!-- 버스있을경우 끝 -->
					</div>
					<div class="stopName">
						<div class="txtName">${i.bsname}</div>
					</div>
				</div>
				<div style="clear: both;"></div>
				<!-- 정류장 리스트 끝 -->
</c:forEach>
			</div>
			<!-- lineArea  -->

		</div>
		
	</div>
</body>
</html>