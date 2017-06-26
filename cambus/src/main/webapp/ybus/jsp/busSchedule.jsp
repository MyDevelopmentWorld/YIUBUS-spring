<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="kr">
<head>
	<meta charset="UTF-8">
	
<style rel="stylesheet">

body {
  background-color: #ffffff;
}
body * {
  box-sizing: border-box;
}

.header {
  background-color: #00dbe9;
  color: white;
  font-size: 1.5em;
  padding: 1rem;
  text-align: center;
  text-transform: uppercase;
}

img {
  border-radius: 50%;
  height: 60px;
  width: 60px;
}

.table-users {
  border: 1px solid #327a81;
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow: hidden;
  width: 800px;
}

table {
  width: 100%;
}
table td, table th {
  color: #2b686e;
  padding: 10px;
}
table td {
  font-size: 2.5em;
  text-align: center;
  vertical-align: middle;
}
table td:last-child {
  font-size: 2.5em;
  line-height: 1.4;
}
table th {
  background-color: #daeff1;
  font-weight: 300;
}
table tr:nth-child(2n) {
  background-color: white;
}
table tr:nth-child(2n+1) {
  background-color: #edf7f8;
}
table tr{
	height: 45px;
}

.notify{
	text-align: center;
}

</style>
<script src="/cambus/ybus/js/jquery-1.12.4.js"></script>
</head>
<body>
<div class="notify">
	<span>#버스가 10분도 안남았을때는 시간표가 깜빡거려요!</span>
</div>
<div class="table-users">
   <div class="header">${bscName}</div>

   <table id="bscTable">
      <tr>
         <th>시간</th>
         <th>순환코스</th>
      </tr>
		
		<c:set var="beforeTime" value="08:00"></c:set>
		<c:forEach var="b" items="${bsclist}" varStatus="ct">
		
		<c:set var="week" value="${fn:split(b.bcperiod,'#')}" />
		<input id="whatweek" type="hidden" value="${week[1]}" />
		<!-- week하나만 알면되므로 ID로 처리 -->
		
			<c:choose>
				<c:when test="${b.currentBsc eq '1' }">
					<tr>
						<%-- <td>${b.bcseq}</td> --%>
				    	<td style="background-color: #00e8ff;">${b.bctime}</td>
				    	<td style="background-color: #00e8ff;">${b.bcline}</td>
				    </tr>
				</c:when>
				<c:when test="${b.currentBsc eq '2' }">
					<tr>
						<td class="blink" style="background-color: #00e8ff;">${b.bctime}</td>
				    	<td class="blink" style="background-color: #00e8ff;">${b.bcline}</td>
				    </tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td>${b.bctime}</td>
				    	<td>${b.bcline}</td>
   					</tr>
				</c:otherwise>
			</c:choose>
			

		</c:forEach>
      

   </table>
</div>

<script type="text/javascript">
$(document).ready(function() {
	
	//테이블 두줄로 만들기
		var totalRow = $("#bscTable").children().children().length;
		var halfRow = Math.round( ($("#bscTable").children().children().length-1)/2 );
		var isBlink = "";
		var isStyle = "";
		$("#bscTable").children().children().eq(0).append("<th>시간</th><th>순환코스</th>");
		
		$("#bscTable").children().children().each(function(i,dom){
			
			var td1 = $(dom).children().eq(0);
			var td2 = $(dom).children().eq(1);
			
			if(i>halfRow){//행이 반이상 넘어갔을때 새로 추가한 th밑에 행을 이동, 이전부분은 삭제
				
				if(typeof(td1.attr("class"))!="undefined" && typeof(td1.attr("style"))!="undefined"){//반 이후로 디자인되있을 경우
					//기존 class와 style이 있을때
					isBlink = td1.attr("class");
					isStyle = td1.attr("style");
					$("#bscTable").children().children().eq(i-halfRow).append("<td class="+isBlink+" style='"+isStyle+"'>"+td1.text()+"</td><td class="+isBlink+" style='"+isStyle+"'>"+td2.text()+"</td>");
				}else if(typeof(td1.attr("style"))!="undefined"){
					//style만 있을때
					isStyle = td1.attr("style");
					$("#bscTable").children().children().eq(i-halfRow).append("<td style='"+isStyle+"'>"+td1.text()+"</td><td style='"+isStyle+"'>"+td2.text()+"</td>");
				}else{
					$("#bscTable").children().children().eq(i-halfRow).append("<td>"+td1.text()+"</td><td>"+td2.text()+"</td>");
				}
				
				$(dom).remove();
			}
		});
	//두줄만들기 끝
	
	var element = $(".blink");
	var shown = true;

	var texts = new Array(element.length);
	
	for(var k=0;k<element.length;k++){
		texts[k] = element.eq(k).text();
	}
	
	var interval = setInterval(toggle, 500);
	
    setTimeout(function(){
        clearInterval(interval);
    },500000);
    //5분뒤 interval 종료

	function toggle() {//깜빡이는 효과
	   if(shown) {
		   for(var i=0;i<element.length;i++){
			   element.eq(i).text("");
		   }
	       shown = false;
	   } else {
		   for(var i=0;i<element.length;i++){
			   element.eq(i).text(texts[i]);
		   }
	       shown = true;
	   }
	}

});

</script>
</body>
</html>
