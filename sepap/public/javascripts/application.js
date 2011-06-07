// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var $j = jQuery.noConflict();
$j(function(){$j('#group_fecha').datepicker($j.datepicker.regional[ "es" ]);});

$j(document).ready(function(){
  $j("#divModulo").hide();
  
  $j("#btnCompleto").click(function(){
    $j("#divModulo").hide();
  });
  
  $j("#btnModulo").click(function(){
    $j("#divModulo").show();
  });
});
