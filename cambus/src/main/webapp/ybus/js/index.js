$(function() {
	$(document).bind('touchmove', function(e) {
		e.preventDefault()
	}); // 스크롤방지


	
	
	
	
	var isAuthOpend = false;

	
	
	// 푸터 트랜지션
	$("#footer").click(function() {
		if (isAuthOpend) {
			console.log("hi");
			$("#footer").css("transform", "translate(0px, 0%)");
		} else {
			console.log("hi2");
			$("#footer").css("transform", "translate(0px, -90%)");
		}
		isAuthOpend = !isAuthOpend;
	});

})// onload

