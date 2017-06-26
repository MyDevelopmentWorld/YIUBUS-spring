<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>YBUS맵</title>
<script src="/cambus/ybus/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src=" http://openapi.map.naver.com/openapi/v2/maps.js?clientId=yZLkZBpGBUq9DPcRUD8i"></script>
<script>
var finish_ajax = 0;
var before_marker = []; //이전마커를 담고 새로운 마커생성되면 이전마커를 삭제하기 위함
var before_label = []; //이전라벨을 담고 새로운 라벨생성되면 이전마커를 삭제하기 위함
$(function(){
	
	var oPoint = new nhn.api.map.LatLng(37.2320152,127.1898561);
	var oMap = new nhn.api.map.Map("map", {
 	point : oPoint, // 지도 중심점의 좌표
 	zoom : 8, // 지도의 축척 레벨
 	//boundary : Array // 지도 생성 시 주어진 array 에 있는 점이 모두 보일 수 있도록 지도를 초기화한다.
 	//boundaryOffset : Number // boundary로 지도를 초기화 할 때 지도 전체에서 제외되는 영역의 크기.
 	enableWheelZoom : true, // 마우스 휠 동작으로 지도를 확대/축소할지 여부
 	enableDragPan : true, // 마우스로 끌어서 지도를 이동할지 여부
 	enableDblClickZoom : true, // 더블클릭으로 지도를 확대할지 여부
 	mapMode : 0, // 지도 모드(0 : 일반 지도, 1 : 겹침 지도, 2 : 위성 지도)
 	//activateTrafficMap : true, // 실시간 교통 활성화 여부
 	//activateBicycleMap : true, // 자전거 지도 활성화 여부
 	minMaxLevel : [1, 14], // 지도의 최소/최대 축척 레벨
 	size : new nhn.api.map.Size(800, 750) // 지도의 크기
 	//detectCoveredMarker : Boolean // 겹쳐 있는 마커를 클릭했을 때 겹친 마커 목록 표시 여부
	});
	
	var mapZoom = new nhn.api.map.ZoomControl(); // - 줌 컨트롤 선언
	mapZoom.setPosition({left:10, top:10});
	oMap.addControl(mapZoom);

	var oTraffic = new nhn.api.map.TrafficMapBtn(); // - 실시간 교통 지도 버튼 선언
    oTraffic.setPosition({top:10, right:110});
	oMap.addControl(oTraffic);

	var oTrafficGuide = new nhn.api.map.TrafficGuide(); // - 교통 범례 선언
    oTrafficGuide.setPosition({
    	bottom : 10,
    	left : 10
    });  // - 교통 범례 위치 지정.
    oMap.addControl(oTrafficGuide);
	
    mapTypeChangeButton = new nhn.api.map.MapTypeBtn(); //지도 타입 버튼 선언
    mapTypeChangeButton.setPosition({top:10, left:50});
    oMap.addControl(mapTypeChangeButton);
    
    makeBusStop(oMap);
    ajax_markers(oMap); //초기버스마커넣기
    intervalAjax(oMap); //이후 계속적으로 마커넣기
});

function makeBusStop(oMap){
	finish_ajax = 0;
	var lat,lng,level;
	
		$("#map").show();
		lat="37.232045";
		lng="127.189971";
		level="9";
		var bus_stations = [
      		{lat:"37.2280616",lng:"127.1712030",'station_name':"1번정류장"},
      		{lat:"37.2375990",lng:"127.1794920",'station_name':"2번정류장"},
      		{lat:"37.2359850",lng:"127.1894860",'station_name':"3번정류장"},
      		{lat:"37.2347640",lng:"127.1983800",'station_name':"4번정류장"},
      		{lat:"37.2352650",lng:"127.2057250",'station_name':"5번정류장"},
      		{lat:"37.2334310",lng:"127.2089470",'station_name':"6번정류장"},
      		{lat:"37.2364319",lng:"127.1884552",'station_name':"7번정류장"},
      		{lat:"37.238969",lng:"127.177890",'station_name':"8번정류장"},
      		{lat:"37.2381310",lng:"127.1781290",'station_name':"9번정류장"}
   		];
		var sPoint = [];
		var sMarker = []; //정류장 위치,마커
				
		for(var i=0; i<bus_stations.length; i++){
			
			var sSize = new nhn.api.map.Size(30, 30);
 			var sOffset = new nhn.api.map.Size(14, 37);
 			var sIcon = new nhn.api.map.Icon('/cambus/ybus/images/busStop/bus_station.png', sSize, sOffset);
 			sMarker[i] = new nhn.api.map.Marker(sIcon, { title : '' });
 			sPoint[i] = new nhn.api.map.LatLng(Number(bus_stations[i].lat), Number(bus_stations[i].lng));
			sMarker[i].setPoint(sPoint[i]);
			oMap.addOverlay(sMarker[i]);
 		}
		
		var oPoint2 = new nhn.api.map.LatLng(lat,lng);
		oMap.setLevel(level);
		oMap.setCenter(oPoint2);

}

//ajax반복
function intervalAjax(oMap){

 var interval = setInterval( function(){
  ajax_markers(oMap);
 }, 10000 );

	setTimeout(function(){
		clearInterval(interval);
	},1000000);
 
};

//ajax한번
function ajax_markers(oMap){
	var oMarker = [];
	var oLabel = [];
    var oPoint3 = []; //같은 경로의 버스들의 위치가 들어갈 배열
    var bus_img;
    if($("#whatLine").val()=="circle"){//셔틀일경우 이미지
    	bus_img="/cambus/ybus/images/bus.png";	
    }else{//노란버스일경우 이미지
    	bus_img="/cambus/ybus/images/yellowbus.png";
    }
    

$.ajax({
	type:"POST",
	url:"/cambus/ybus/exchangeJson/getPositions.do",
	data : {
		"line" : $("#whatLine").val() // 받아온 파라메터를 process 로 날린다.
	},
	dataType : "json",
	success: function(result){
	var res = result.busmap;
	console.log(res);
 	if(result == null){

	}else{
		if (before_marker != null && before_label != null) { //이전 마커와 라벨이 있으면 삭제한다
				for(var i=0; i<before_marker.length; i++){
				oMap.removeOverlay(before_marker[i]);
				//oMap.removeOverlay(before_label[i]);
			}
		}
	

	for(var i=0; i<res.length; i++){
		var d = new Date();

 	var oSize = new nhn.api.map.Size(40, 50);
 	var oOffset = new nhn.api.map.Size(14, 37);
 	var oIcon = new nhn.api.map.Icon(bus_img, oSize, oOffset);
 	oMarker[i] = new nhn.api.map.Marker(oIcon, { title : res[i].busid });
 	
 	oMarker[i].attach('click', function(oEvent) {
 	   alert(oEvent.target.getTitle());
 	});

    oPoint3[i] = new nhn.api.map.LatLng(Number(res[i].blat),Number(res[i].blng));
	oMarker[i].setPoint(oPoint3[i]);
 	oMap.addOverlay(oMarker[i]);
 	
   }


   before_marker = oMarker; //이전 마커를 지우기 위해

}//else 끝
   
	finish_ajax = 1;
	$("#progress").empty();
	
  },
  error : function(xhr,error,status){
   console.log(xhr+"|"+error+"|"+status);
  }
 });
}
</script>
<style>
span{
	margin:0;
	padding:0;
}
html, body{
	position:relative;
	margin:0;
	padding:0;
	
}

#area{
	position:relative;
	width:100%;
	max-width:800px;
	height:100%;
	margin:0 auto;
}
#map_area{
	position:relative;
	width:100%;
	height:90%;
	
}
#notice{
	position:relative;
	width:100%;
	height:10%;
	background-color:white;
	text-align:center;
	font-size: 35px;
}
#map{
	width:100%;
	height:100%;
}
#headArea {
	position: relative;
	top: 0;
	left: 0;
	width: 100%;
	height: 50px;
	background-color: #003d4f;
	color: white;
	text-align: center;
	color: white;
	text-align: center;
	line-height: 3;
}
</style>
</head>
<body>
<input id="whatLine" type="hidden" value="${param.line}">  
	<div id="headArea">
			실시간 버스 조회 <img src="/cambus/ybus/images/busStop/topLogo.png" style="position: absolute; right: 0;height:100%;width:auto;" />
			<input type="button" value="<" style="color:white;position: absolute; font-size:1.5em;left: 3%; width: 8%; height: 70%;  background-color: transparent !important; border-color: transparent;"	onclick="history.go(-1);" />
	</div>
	<div id="area">
	
	<div id="notice">#버스위치는 10초마다 자동 갱신됩니다</div>
	
	<div id="map_area">
		<div id="progress"></div>
		<div class="view_map" id="map"></div>
	</div>
	
	</div>
</body>
</html>

