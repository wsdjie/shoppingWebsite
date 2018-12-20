<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>操作失败！</title>
    <link rel="stylesheet" href="admin/css/common.css" type="text/css" />
    <style type="text/css">
    body{margin:0px;text-align:center;}
    
    #div_all{text-align:left;margin-left:auto;margin-right:auto;}
    #error_tip{height:150px;line-height:150px;text-align:center;border-bottom:1px dashed #EF1D1E;font-size:24pt;font-family:'黑体';color:#EF1D1E;padding:20px 0px 20px 0px;}
    img{vertical-align:middle;}
    #error_info{padding-top:50px;text-align:left;font-size:10pt;color:#EF1D1E;}
    #error_info a{color:#1F8E1F;}
    </style>
  </head>
  
  <body>
  	<div class="opDiv">
		<div class="titlebar">操作失败</div>
	</div>
    <div id="div_all">
    	<div id="error_tip"><img src="images/error.gif" />操作失败！</div>
    	<%Object msg = request.getAttribute("msg"); %>
    	<div id="error_info"><%=msg==null?"":msg%>&nbsp;&nbsp;
    		<a target="_self" href="javascript:window.history.back();">返回</a></div>
  	</div>
  </body>
</html>
