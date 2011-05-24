// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var $j = jQuery.noConflict();
/*ANIMACION DEL MENU*/
$j(document).ready(function(){
  $j("a.botones").mouseover(function(){
  	$j(this).stop();
  	$j(this).css("border-color","#FFFFFF");
  	$j(this).animate({width:"100%"},"fast",function(){
  		$j(this).animate({backgroundPosition:'-400px 0px'},"fast");
  	});
  });    
  $j("a.botones").mouseleave(function(){
  	$j(this).stop();
    $j(this).animate({backgroundPosition: '0px 0px'},"fast",function(){
    	$j(this).animate({width:"50%"},"fast");
    });
  });
});
