// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var $j = jQuery.noConflict();
$j(function(){$j('#group_fecha').datepicker($j.datepicker.regional[ "es" ]);});

$j(document).ready(function(){
    $j("#divModulo").hide();
  
    $j("#spInfoSol").hide()
  
    $j("#spInfoMod").hide()
    
    $j("#spInfoEntrada").hide()
        
    $j("#spInfoSalida").hide()

    $j("#spInfoPw").hide()
    
     $j("#spInfoMiembros").hide()
     
     $j("#spInfoCodigo").hide()
     
     $j("#agregaalumno").hide()
  
  $j("#btnCompleto").click(function(){
    $j("#divModulo").hide();
  });
  
  
  
    $j("#infoCodigo").mouseover(function(){
    $j("#spInfoCodigo").show();
  });
  
  $j("#infoCodigo").mouseout(function(){
    $j("#spInfoCodigo").hide();
  });
  
  
  
  $j("#infoSol").mouseover(function(){
    $j("#spInfoSol").show();
  });
  
  $j("#infoSol").mouseout(function(){
    $j("#spInfoSol").hide();
  });
  
  
  
  $j("#infoMod").mouseover(function(){
    $j("#spInfoMod").show();
  });
  
  $j("#infoMod").mouseout(function(){
    $j("#spInfoMod").hide();
  });
  
  
  
    $j("#infoEntrada").mouseover(function(){
    $j("#spInfoEntrada").show();
  });
  
    $j("#infoEntrada").mouseout(function(){
    $j("#spInfoEntrada").hide();
  });
  
  
  
    $j("#infoSalida").mouseover(function(){
    $j("#spInfoSalida").show();
  });
  
    $j("#infoSalida").mouseout(function(){
    $j("#spInfoSalida").hide();
  });
  
  
    $j("#infoPw").mouseover(function(){
    $j("#spInfoPw").show();
  });
  
    $j("#infoPw").mouseout(function(){
    $j("#spInfoPw").hide();
  });
  
  
  
    $j("#infoMiembros").mouseover(function(){
    $j("#spInfoMiembros").show();
  });
  
    $j("#infoMiembros").mouseout(function(){
    $j("#spInfoMiembros").hide();
  });


  $j("#btnAgregar").click(function(){
    $j("#textoAgregar").hide();
    $j("#agregaalumno").show();
  });  
  
  $j("#btnModulo").click(function(){
    $j("#divModulo").show();
  });
});
