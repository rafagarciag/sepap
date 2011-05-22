// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/*ANIMACION DEL MENU*/
$(document).ready(function(){
  $("a.botones").mouseover(function(){
  	$(this).stop();
  	$(this).css("border-color","#FFFFFF");
  	$(this).animate({width:"100%"},"fast",function(){
  		$(this).animate({backgroundPosition:'-400px 0px'},"fast");
  	});
  });    
  $("a.botones").mouseleave(function(){
  	$(this).stop();
    $(this).animate({backgroundPosition: '0px 0px'},"fast",function(){
    	$(this).animate({width:"50%"},"fast");
    });
  });
});
