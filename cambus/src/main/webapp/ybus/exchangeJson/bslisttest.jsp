<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		var data = "busId=00000000-152a-f094-ac5e-b5ae762d4c9c";
		
		$.ajax({
			url : 'http://ybus.kro.kr/ybus/ybus/exchangeJson/getBsList.do',
			method : "post",
			data : data,
			success : function(data, stat, xhr) {
				console.log(data);
				$("#text").text(data);
			},
			error : function(xhr, stat, err) {
				console.log(err);
			}
		});

	});
</script>
</head>
<body>
<span id="text"></span>
</body>
</html>