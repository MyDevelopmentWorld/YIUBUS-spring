<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Cambus</title>

<!-- ����Ͽ��� -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />

<meta name="mobile-web-app-capable" content="yes">


<!-- ico ������-->
<!-- <link rel="apple-touch-icon" href="/mobile/Image/favicon.ico"> -->

<script src="/cambus/ybus/js/jquery-1.12.4.js"></script>
<script src="/cambus/ybus/js/jquery.cycle.all.js"></script>
<script src="/cambus/ybus/js/popup.js"></script>
<link rel="stylesheet" href="/cambus/ybus/css/main.css">
<link rel="stylesheet" href="/cambus/ybus/css/bootstrap.min.css">

<!-- ���μ��� ��ũ�ѹ��� ��ũ��Ʈ -->
<script src="/cambus/ybus/js/index.js"></script>

</head>
<body>
	<div id="container">

		<div id="headArea">
			<div id="noticeArea">
				<div id="noticeIconArea">
					<img src="/cambus/ybus/images/icon_notice.png" id="noticeIcon" /> 
				</div>
				<!-- <div id="noticeTextArea">[��������] <a href="http://ybus.kr" style="text-decoration:none">YBUS open!</a></div> -->
				<div id="noticeTextArea">
				    <div>[��������] <a href="#" style="text-decoration:none">���нð�ǥ�� ����</a></div>
				    <!-- ���� ����ģ�� �������� �Ѹ����� -> 2������ -->
				    <!-- <div>[��������] <a href="http://ybus.kr" style="text-decoration:none">MBUS open!</a></div>
				    <div>[��������] <a href="http://ybus.kr" style="text-decoration:none">GBUS open!</a></div> -->
				</div>
				<div class="clear"></div>
			</div>
		</div>


		<div id="contents">
			<div id="space1" class="bigBox">
				<div class="inBox">
					<div id="smallInBox1" class="smallInBox">
						Have a nice day<br> ������ ���� &nbsp<span id="weather"></span>
					</div>
					<div id="smallInBox2" class="smallInBox"></div>
				</div>

			</div>
			<div id="space2" class="box">
				<img src="/cambus/ybus/images/2_blank.png"/>
			</div>
			<div id="space3" class="box">
				<img src="/cambus/ybus/images/cambus_new.png" id="checkfood"/>
			</div>
			<div class="clear"></div>
			<div id="space4" class="box">
				<img src="/cambus/ybus/images/bigbuslocation_new.png" id="shuttlelocation"/>
			</div>
			<div id="space5" class="box">
				<img src="/cambus/ybus/images/yellowbuslocation_new.png" id="yellowshuttlelocation"/>
			</div>
			<div id="space6" class="box">
				<img src="/cambus/ybus/images/taxishare_new.png" id="taxiShare"/>
			</div>
			<div class="clear"></div>
			<div id="space7" class="box">
				<img src="/cambus/ybus/images/weekbs.png" id="timeTable"/>
			</div>
			<div id="space8" class="box">
				<img src="/cambus/ybus/images/weekendbs.png" id="timeTable_weekend"/>
			</div>
			<div id="space9" class="box">
				<image src="/cambus/ybus/images/generalbus.png" id="buslocation"/>
			</div>
			<div class="clear"></div>
		</div>
		<!-- 
		<div id="footer">
			<p id="copyRight">Click Here!!</p>
			<p id="introduce"></p>
		</div>
		 -->
	</div>
	<form id="chatFrm" name="chatFrm">
	<input type="hidden" id="startTxt" name="startTxt"/>
	<input type="hidden" id="destTxt" name="destTxt"/>
	<div id="lay_pop">
		<div class='whereList'>
		 <span class="dropdown-el" id="startLoc">
		   <input type="radio" name="startList" value="startchoice" checked="checked" id="slist1"><label for="slist1">����� ����</label>
		   <input type="radio" name="startList" value="mjcross" id="slist2"><label for="slist2">�������Ÿ�</label>
		   <input type="radio" name="startList" value="emedical" id="slist3"><label for="slist3">�̾౹ ��</label>
		   <input type="radio" name="startList" value="moonye" id="slist4"><label for="slist4">����ȸ�� ��</label>
		   <input type="radio" name="startList" value="yicity" id="slist5"><label for="slist5">���ν�û ������ ��</label>
		   <input type="radio" name="startList" value="mjstation" id="slist6"><label for="slist6">�����뿪</label>
		   <input type="radio" name="startList" value="yienter" id="slist7"><label for="slist7">���δ��б� ����</label>
		   
		 </span>
		 <p>
		 <span class="dropdown-el" id="destLoc">
		   <input type="radio" name="destList" value="destchoice" checked="checked" id="dlist1"><label for="dlist1">������ ����</label>
		   <input type="radio" name="destList" value="toyongin" id="dlist2"><label for="dlist2">���δ� ���</label>
		   <input type="radio" name="destList" value="tojinip" id="dlist3"><label for="dlist3">���Է� ���</label>
		 </span>
		 
		</div>
		
		<div class="inputInfo">
			 
			 <input type="text" name="nickName" id="nickName" class="input-medium" placeholder="����� �г��� �Է�"/>
			 <input type="text" id="phoneNum" name="phoneNum" class="input-medium bfh-phone" data-format="ddd-dddd-dddd" placeholder="����ȣ �Է�('-'����)" style="margin-top: 3%"/>
			 <p>
			 <input type="checkbox" id="checkPhone"/>
			 <span>����ȣ �Է¾���</span> 
	    	     
		</div>
		
		<div class='buttons'>
			<input id="goToChatBtn" class="defaultBtn" type="button" value="ä�ù� ����" />
			<input class="defaultBtn2" type="button" onclick="layerClose('lay_pop','all_body')" value="�ݱ�" />
		</div>
	</div>
	</form>
	<div id="all_body"></div>
<script>
$(function() {
	
	
	//popup list start
	$('.dropdown-el').click(function(e) {
		  e.preventDefault();
		  e.stopPropagation();
		  $(this).toggleClass('expanded');
		  $('#'+$(e.target).attr('for')).prop('checked',true);
		});
	$(document).click(function() {
	  $('.dropdown-el').removeClass('expanded');
	});
	//popup list end
	
	$("#noticeTextArea").cycle({
	    fx:     'scrollDown', 
	    delay:  -2000 
	});
	
	/* ����������������*/
	$.ajax({
		url : "/cambus/ybus/ajax/getweather.jsp",
		dataType : "text",
		success : function(res) {
			//console.log( $( $.trim(res) ).find("data").first().children().eq(2).text() );//����ð� �µ�
			//console.log( $( $.trim(res) ).find("data").first().children().eq(7).text() );//����ð� ����
			var temp = $($.trim(res)).find("data").first().children().eq(2).text();
			var temp2 = $( $.trim(res) ).find("data").first().children().eq(7).text();
			temp = temp.split(".");
			$("#smallInBox2").text(temp[0]+"��");
			$("#weather").text(temp2);
		}
	});/* ���������������� ��*/
	
    $("img#checkfood").click(function(){
        viewCount($(this).attr("id"));
        document.location.href = "http://eeu1234.cafe24.com/mobile/FOOD/Food.php";
    });
	
	$("img#shuttlelocation").click(function() {
		viewCount($(this).attr("id"));
		document.location.href = "circlebus.do?line=circle";
	});
	
	$("img#yellowshuttlelocation").click(function() {
		viewCount($(this).attr("id"));
		document.location.href = "yellowbus.do?line=yellow";
	});
	
	$("img#buslocation").click(function() {
		viewCount($(this).attr("id"));
		document.location.href = "generalbus.jsp";
	});

	$("img#taxiShare").click(function() {
		viewCount($(this).attr("id"));
		pushLayer();
	});

	$("img#timeTable").click(function() {
		viewCount($(this).attr("id"));
		document.location.href = "BusSchedule.do?bscType=week";
	});

	$("img#timeTable_weekend").click(function() {
		viewCount($(this).attr("id"));
		document.location.href = "BusSchedule.do?bscType=weekend";
	});
	
	//���Է� ���ϱ� ��ư Ŭ����
	$("#checkPhone").click(function(){
		console.log($("#checkPhone").is(":checked"));
		//$("#phoneNum").toggleClass("inactive","active");
		
		$( "#phoneNum" ).toggleClass(function() {
			  if ( $("#checkPhone").is(":checked")==true ) {
				  $( "#phoneNum" ).attr("readonly","readyonly");
				  $( "#phoneNum" ).val("��ȣ����");
				  $( "#phoneNum" ).attr("placeholder","�Է¾���");
				  
				  return "inactive";
			  }else{
				  $( "#phoneNum" ).removeAttr( "readonly" );
				  $( "#phoneNum" ).attr("placeholder","����ȣ �Է�('-'����)");
			  }
			});
		//console.log($("#phoneNum").val());
		/* if($("#checkPhone").is(":checked")==true){
				//$("#phoneNum").toggleClass("inactive","active");
		} */
	});
	
	//ä�ù� ���� ��ư
	$("#goToChatBtn").click(function(){
		
		var valiCount = 0;
		
		//�ѱ۸����� ������ ���� ���
		$("input[name=startList]").each(function(){
			if($(this).is(":checked")==true && $(this).val()=="startchoice"){
				alert("������� ������ �ּ���");
				return false;
			}else if($(this).is(":checked")==true && $(this).val()!="startchoice"){
				$("#startTxt").val($(this).next().text());
				valiCount++;
			}
		});
		
		$("input[name=destList]").each(function(){
			if($(this).is(":checked")==true && $(this).val()=="destchoice"){
				alert("�������� ������ �ּ���");
				return false;
			}else if($(this).is(":checked")==true && $(this).val()!="destchoice"){
				$("#destTxt").val($(this).next().text());
				valiCount++;
			}
		});
		
		if($("#phoneNum").val().length!=11 && $("#checkPhone").is(":checked")!=true){
			alert("�ڵ�����ȣ�� Ȯ���Ͽ� �ּ���");
			return false;
		}else if($("#nickName").val().length==0){
			alert("�г����� �Է��� �ּ���");
			return false;
		}else{
			valiCount++;
		}
		
		if(valiCount==3){
			$("form[name=chatFrm]").attr({action:'chattingRoom.jsp', method:'post'}).submit();
		}
		
		
	});

});
function viewCount(name){
	
	var data = {"pagename":name}
	
	$.ajax({
		url : "viewCount.do",
		dataType : "text",
		type:"post",
		data: data,
		success : function(res) {
			console.log(res);
		}
	});
}

</script>
<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "159230fe9a3b530";
wcs_do();
</script>
</body>
</html>
