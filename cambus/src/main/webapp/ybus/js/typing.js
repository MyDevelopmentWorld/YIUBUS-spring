var $cover;
var limitTime = 60;
target = new Array();
var flag = false;

$(function() {
	prepare();
	$(document.body).keyup(start);
	
	function makeTarget() {
		
		$.get("target-word.txt", function(data) {
			target = data.split("\n");
			console.log(target.length);
		});
		
		setTimeout(function(){
		console.log(target.length);
		},1000);
		
		
	}


function prepare() {
	$("<div id='cover'>").appendTo(document.body);
	$cover = $("#cover");
	var html = "<h1>타자 연습 게임</h1>";
	html += "<p>시작하면 단어가 떨어지며 단어를 그대로 입력 후 엔터를 누르면 제거됩니다.</p>";
	html += "<p>제한 시간 : " + limitTime + "초</p>";
	html += "<p>게임을 시작하려면 스페이스바를 누르세요!</p>"
	$cover.addClass("cover").html(html);
}

function start(event) {
	var keyCode = event.which || event.keyCode;

	if (!flag && keyCode == 32) {		
		$("#cover").hide();	
	makeTarget();
		flag = true;
	}
}
});
