<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
	$("#locationBtn").click(function(){
		var obj = document.locationFrm;
		obj.submit();
	})
})
</script>
<body>
<!-- <form name="locationFrm" method="POST" action="http://ybus.kro.kr/cambus/ybus/exchangeJson/setLocation.do"> -->
<form name="locationFrm" method="POST" action="/cambus/ybus/exchangeJson/setLocation.do">
<input type="text" name="bpk" value="" />
<input type="text" name="blat" value="" />
<input type="text" name="blng" value="" />
<input type="button" id="locationBtn" value="CLICK"/>
</form>
</body>
</html>