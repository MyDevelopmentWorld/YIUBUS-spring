function pushLayer(){
	var $width=parseInt($("#lay_pop").css("width"));
	var $height=parseInt($("#lay_pop").css("height"));
	var left=($(window).width()-$width)/2;
	var sctop=$(window).scrollTop()*2;
	var top=($(window).height()-$height+sctop)/2;
	var height=document.getElementsByTagName("body")[0].scrollHeight;
	$("#lay_pop").css("left",left);
	$("#lay_pop").css("top",top);
	$("#lay_pop").css("display","block");
	$("#lay_pop").css("z-index","555");
	$("#all_body").css("display","block");
	$("#all_body").css("width",$(window).width());
	$("#all_body").css("height",height);

}
function layerClose(lay1,lay2){
	$("#"+lay1).css("display","none");
	$("#"+lay2).css("display","none");
}

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