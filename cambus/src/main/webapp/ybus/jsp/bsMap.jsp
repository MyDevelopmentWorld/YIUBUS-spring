<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>YBUS��</title>
<script src="/cambus/ybus/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src=" http://openapi.map.naver.com/openapi/v2/maps.js?clientId=yZLkZBpGBUq9DPcRUD8i"></script>
<script>
var finish_ajax = 0;
var before_marker = []; //������Ŀ�� ��� ���ο� ��Ŀ�����Ǹ� ������Ŀ�� �����ϱ� ����
var before_label = []; //�������� ��� ���ο� �󺧻����Ǹ� ������Ŀ�� �����ϱ� ����
$(function(){
	
	var oPoint = new nhn.api.map.LatLng(37.2320152,127.1898561);
	var oMap = new nhn.api.map.Map("map", {
 	point : oPoint, // ���� �߽����� ��ǥ
 	zoom : 8, // ������ ��ô ����
 	//boundary : Array // ���� ���� �� �־��� array �� �ִ� ���� ��� ���� �� �ֵ��� ������ �ʱ�ȭ�Ѵ�.
 	//boundaryOffset : Number // boundary�� ������ �ʱ�ȭ �� �� ���� ��ü���� ���ܵǴ� ������ ũ��.
 	enableWheelZoom : true, // ���콺 �� �������� ������ Ȯ��/������� ����
 	enableDragPan : true, // ���콺�� ��� ������ �̵����� ����
 	enableDblClickZoom : true, // ����Ŭ������ ������ Ȯ������ ����
 	mapMode : 0, // ���� ���(0 : �Ϲ� ����, 1 : ��ħ ����, 2 : ���� ����)
 	//activateTrafficMap : true, // �ǽð� ���� Ȱ��ȭ ����
 	//activateBicycleMap : true, // ������ ���� Ȱ��ȭ ����
 	minMaxLevel : [1, 14], // ������ �ּ�/�ִ� ��ô ����
 	size : new nhn.api.map.Size(800, 750) // ������ ũ��
 	//detectCoveredMarker : Boolean // ���� �ִ� ��Ŀ�� Ŭ������ �� ��ģ ��Ŀ ��� ǥ�� ����
	});
	
	var mapZoom = new nhn.api.map.ZoomControl(); // - �� ��Ʈ�� ����
	mapZoom.setPosition({left:10, top:10});
	oMap.addControl(mapZoom);

	var oTraffic = new nhn.api.map.TrafficMapBtn(); // - �ǽð� ���� ���� ��ư ����
    oTraffic.setPosition({top:10, right:110});
	oMap.addControl(oTraffic);

	var oTrafficGuide = new nhn.api.map.TrafficGuide(); // - ���� ���� ����
    oTrafficGuide.setPosition({
    	bottom : 10,
    	left : 10
    });  // - ���� ���� ��ġ ����.
    oMap.addControl(oTrafficGuide);
	
    mapTypeChangeButton = new nhn.api.map.MapTypeBtn(); //���� Ÿ�� ��ư ����
    mapTypeChangeButton.setPosition({top:10, left:50});
    oMap.addControl(mapTypeChangeButton);
    
    makeBusStop(oMap);
    ajax_markers(oMap); //�ʱ������Ŀ�ֱ�
    intervalAjax(oMap); //���� ��������� ��Ŀ�ֱ�
});

function makeBusStop(oMap){
	finish_ajax = 0;
	var lat,lng,level;
	
		$("#map").show();
		lat="37.232045";
		lng="127.189971";
		level="9";
		var bus_stations = [
      		{lat:"37.2280616",lng:"127.1712030",'station_name':"1��������"},
      		{lat:"37.2375990",lng:"127.1794920",'station_name':"2��������"},
      		{lat:"37.2359850",lng:"127.1894860",'station_name':"3��������"},
      		{lat:"37.2347640",lng:"127.1983800",'station_name':"4��������"},
      		{lat:"37.2352650",lng:"127.2057250",'station_name':"5��������"},
      		{lat:"37.2334310",lng:"127.2089470",'station_name':"6��������"},
      		{lat:"37.2364319",lng:"127.1884552",'station_name':"7��������"},
      		{lat:"37.238969",lng:"127.177890",'station_name':"8��������"},
      		{lat:"37.2381310",lng:"127.1781290",'station_name':"9��������"}
   		];
		var sPoint = [];
		var sMarker = []; //������ ��ġ,��Ŀ
				
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

//ajax�ݺ�
function intervalAjax(oMap){

 var interval = setInterval( function(){
  ajax_markers(oMap);
 }, 10000 );

	setTimeout(function(){
		clearInterval(interval);
	},1000000);
 
};

//ajax�ѹ�
function ajax_markers(oMap){
	var oMarker = [];
	var oLabel = [];
    var oPoint3 = []; //���� ����� �������� ��ġ�� �� �迭
    var bus_img;
    if($("#whatLine").val()=="circle"){//��Ʋ�ϰ�� �̹���
    	bus_img="/cambus/ybus/images/bus.png";	
    }else{//��������ϰ�� �̹���
    	bus_img="/cambus/ybus/images/yellowbus.png";
    }
    

$.ajax({
	type:"POST",
	url:"/cambus/ybus/exchangeJson/getPositions.do",
	data : {
		"line" : $("#whatLine").val() // �޾ƿ� �Ķ���͸� process �� ������.
	},
	dataType : "json",
	success: function(result){
	var res = result.busmap;
	console.log(res);
 	if(result == null){

	}else{
		if (before_marker != null && before_label != null) { //���� ��Ŀ�� ���� ������ �����Ѵ�
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


   before_marker = oMarker; //���� ��Ŀ�� ����� ����

}//else ��
   
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
			�ǽð� ���� ��ȸ <img src="/cambus/ybus/images/busStop/topLogo.png" style="position: absolute; right: 0;height:100%;width:auto;" />
			<input type="button" value="<" style="color:white;position: absolute; font-size:1.5em;left: 3%; width: 8%; height: 70%;  background-color: transparent !important; border-color: transparent;"	onclick="history.go(-1);" />
	</div>
	<div id="area">
	
	<div id="notice">#������ġ�� 10�ʸ��� �ڵ� ���ŵ˴ϴ�</div>
	
	<div id="map_area">
		<div id="progress"></div>
		<div class="view_map" id="map"></div>
	</div>
	
	</div>
</body>
</html>

