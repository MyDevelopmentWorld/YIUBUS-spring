<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true"%>
<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>YBUS-택시같이타요</title>
    <!-- BOOTSTRAP CORE STYLE CSS -->
    <link href="/cambus/ybus/css/chatstyle.css" rel="stylesheet" />
	<script type="text/javascript" src="/cambus/ybus/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/cambus/ybus/js/sockjs.js"></script>
	<!-- <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.1/sockjs.min.js"></script> -->
	
</head>
<script>

var whatDest;
var nickName;
var phoneNum;

function connect(){

wsocket = new SockJS("http://ybus.kr/cambus/taxiChat?data="+whatDest+"_"+nickName+"_"+phoneNum);

wsocket.onopen = onOpen;
wsocket.onmessage = onMessage;
wsocket.onclose = onClose;
}
function disconnect() {
wsocket.close();
}
function onOpen(evt) {
	var str = "";
		str += "<div style='text-align: center'>";
		str += "	<span>채팅을 시작합니다.</span>";
		str += "</div>";
	$("#chatRoom").children().eq(0).append(str);
}

function onClose(evt) {
	appendMessage("연결을 끊었습니다.");
}

//메세지 수신
function onMessage(evt) {
	var data = evt.data;
	
	//초기 연결시 보낸 id저장
	if (data.substring(0, 1) == "!") {
		$("#myId").val(data.substring(1));
	}
	
	//새로운 유저 접속시마다 유저리스트 갱신
	else if (data.substring(0, 4) == "info") {
		updateUserList(data);
	}
	
	else if (data.substring(0, 5) == "clear") {
		var ul = $("#userList").children().eq(0);
		$(ul).html("");
	}
	
	else{
	 appendMessage(data);
	}

}

function send() {
var msg = $("#messageText").val();
wsocket.send("msg#"+whatDest+"#" + msg);
$("#messageText").val("");
}

function updateUserList(data){
	
	console.log(data);
	var currentCount = $("#currentCount");
	var ul = $("#userList").children().eq(0);
	//info#전필원#112#fromMe#1
	var infos = data.split("#");
	var nickName=infos[1];
	
	if(infos[2]=="번호없음"){
		var phoneNum="번호없음"
	}else{
		var phoneNum=infos[2].substring(0,3)+"-"+infos[2].substring(3,7)+"-"+infos[2].substring(7,11);	
	}
	
	var img;
	if(infos[3]=="fromMe"){
		img="/cambus/ybus/images/icon.png";
		nickName+="(나)";
	}else{
		img="/cambus/ybus/images/person.png";
	}


var str = "";
str += "<li class='media' name='userInfo'>";
str += "	<input type='hidden' value='0'>";
str += "      <div class='media-body'>";
str += "          <div class='media'>";
str += "              <a class='pull-left' href='#'>";
str += "                  <img class='media-object img-circle' style='max-height:40px;' src='"+img+"' />";
str += "              </a>";
str += "              <div class='media-body' name='detailInfo'>";
str += "                  <h5>"+nickName+" | "+phoneNum+" </h5>";
str += "                 <small class='text-muted'>접속중</small>";
str += "              </div>";
str += "          </div>";
str += "	<div style='display: none'>";
str += "		<ul class='callAndMessage'>";
str += "		<li><a href='tel:"+phoneNum+"'>전화걸기</a></li>";
str += "		<li><a href='sms:"+phoneNum+"'>문자 보내기</a></li>";
str += "		</ul>";
str += "	</div>";
str += "      </div>";
str += "</li>";

ul.append(str);
currentCount.text(infos[4]);
}

function appendMessage(data) {
	
	var msg = data.split("#");
	var message = msg[2];
	var nickName = msg[4];

	var now = new Date();
	var hours;
	console.log(now.getHours());
	var amPm;
	if(now.getHours()>=6 && now.getHours()<=8){
		amPm = "아침";
		hours = now.getHours();
	}else if(now.getHours()>=9 && now.getHours()<=12){
		amPm = "오전";
		hours = now.getHours();
	}else if(now.getHours()>=13 && now.getHours()<=15){
		amPm = "낮";
		hours = now.getHours()-12;
	}
	else if(now.getHours()>=16 && now.getHours()<=20){
		amPm = "오후";
		hours = now.getHours()-12;
	}
	else if(now.getHours()>=21 && now.getHours()<=24){
		amPm = "밤";
		hours = now.getHours()-12;
	}else if(now.getHours()==0){
		amPm = "늦은 밤";
		hours = now.getHours();
	}else if(now.getHours()>=1 && now.getHours()<=5){
		amPm = "새벽";
		hours = now.getHours();
	}

	var nowTime = amPm +" "+ hours + ":" + now.getMinutes();

if(msg[3]=="fromMe"){
	
var str = "<li class='media'>";
str += "<div class='media-body'>";
str += "    <div class='media'>";
str += "       <a class='pull-right' href='#'>"; 
str += "       <img class='media-object img-circle ' style='max-height:80px;' src='/cambus/ybus/images/icon.png' />"; 
str += "       </a>";
str += "        <div class='media-body pull-right' >";
str += message;
str += "            <br />";
str += "           <small class='text-muted'>"+nickName+" | "+nowTime+"</small>";
str += "            <hr />";
str += "        </div>";
str += "    </div>";
str += "</div>";
str += "</li>";

}else{
	
var str = "<li class='media'>";
str += "<div class='media-body'>";
str += "    <div class='media'>";
str += "        <a class='pull-left' href='#'>";
str += "            <img class='media-object img-circle ' style='max-height:80px;' src='/cambus/ybus/images/person.png' />";
str += "        </a>";
str += "        <div class='media-body' >";
str += message;
str += "            <br />";
str += "           <small class='text-muted'>"+nickName+" | "+nowTime+"</small>";
str += "            <hr />";
str += "        </div>";
str += "    </div>";
str += "</div>";
str += "</li>";
}


$("#chatRoom").children().eq(0).append(str);
$("#chatRoom").scrollTop(1000000);
}

$(function(){
	
		whatDest = $("#whatDest").val();
		nickName = encodeURIComponent($("#nickText").val());
		phoneNum = $("#phoneText").val();
		connect();	
	
	//채팅 접속 버튼
	/* $("#connectBtn").click(function(){
		whatDest = $("#whatDest").val();
		nickName = encodeURIComponent($("#nickText").val());
		phoneNum = $("#phoneText").val();
		connect();	
	}); */
	//채팅 종료버튼
		/* $("#exitBtn").click(function(){
			disconnect();	
		}); */
		
	  $('#messageText').keypress(function(event){
		   var keycode = (event.keyCode ? event.keyCode : event.which);
		   if(keycode == '13'){
		    send(); 
		   }
		   event.stopPropagation();
	  });
	  $('#sendBtn').click(function() { send(); });
			  
			  
				//사용자 리스트에 관한 UI
				$(document).on( "click","div[name='detailInfo']",function() {
			    	//한번눌려져있을때
					if($(this).parent().parent().prev().val()=="1"){
						$(this).attr("style","background-color: white;");
						$(this).parent().next().attr("style","display: none");
						$(this).parent().parent().prev().val("0");
					}else{
					//처음 누를때
						$("li[name='userInfo']").each(function(i,dom){
							$("li[name='userInfo']").eq(i).children().eq(1).children().eq(1).attr("style","display: none");
							$("li[name='userInfo']").eq(i).children().eq(0).val("0");
						});
						
						$("div[name='detailInfo']").each(function(i,dom){
							$(dom).attr("style","background-color: white;");
						});
					
						
						$(this).attr("style","background-color: skyblue;");
						$(this).parent().next().attr("style","display: inline");
						$(this).parent().parent().prev().val("1");
					}
					
				});
				////사용자 리스트에 관한 UI 끝
		
});
</script>
<body style="font-family:Verdana">
  <div class="container">
<div class="row " style="padding-top:40px;">
    <h3 class="text-center" >${param.startTxt} -> ${param.destTxt} </h3>
    <input type="hidden" id="myId" />
    <input type="hidden" id="whatDest" value="${param.startList}to${param.destList}" />
    <input type="hidden" id="nickText" value="${param.nickName}" />
    <input type="hidden" id="phoneText" value="${param.phoneNum}" />
    
    <!-- <button class="btn btn-info" type="button" id="connectBtn">채팅시작</button>
    <button class="btn btn-info" type="button" id="exitBtn">채팅종료</button> -->
    <br /><br />
        <div class="col-md-4">
          <div class="panel panel-primary">
            <div class="panel-heading">
               접속리스트 (현재 인원: <span id="currentCount">0</span>명)<p>
               리스트 유저를 터치시 전화/문자가 가능합니다.
            </div>
            <div class="panel-body" id="userList">
                <ul class="media-list">
				</ul>
            </div>
         </div>
        
    </div>
    <div class="col-md-8">
        <div class="panel panel-info">
            <div class="panel-heading">
                채팅방
            </div>
            <div class="panel-body" id="chatRoom">
				<ul class="media-list">
				
                </ul>
            </div>
            <div class="panel-footer">
                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Enter Message" id="messageText"/>
                                    <span class="input-group-btn">
                                        <button class="btn btn-info" type="button" id="sendBtn">SEND</button>
                                    </span>
                                </div>
            </div>
        </div>
    </div>
</div>
  </div>
</body>
</html>
