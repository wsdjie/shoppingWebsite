<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>操作成功！</title>
    <link rel="stylesheet" href="admin/css/common.css" type="text/css" />
    <style type="text/css">
    body{margin:0px;text-align:center;}
    #div_all{text-align:left;margin-left:auto;margin-right:auto;}
    #msg_tip{height:80px;line-height:80px;text-align:center;border-bottom:1px dashed #1F8E1F;font-size:24pt;font-family:'黑体';color:#1F8E1F;padding:20px 0px 20px 0px;}
    img{vertical-align:middle;width:80px;height:80px;}
    #msg_info{height:200px;padding-top:50px;text-align:left;font-size:10pt;color:#1F8E1F;}
    #msg_info a{color:#EF1D1E;}
    </style>
  </head>
  
  <body>
  	<div class="opDiv">
		<div class="titlebar">操作成功</div>
	</div>
    <div id="div_all">
    	<div id="msg_tip"><img src="images/ok.png" />操作成功！</div>
    	<%Object msg = request.getAttribute("msg"); %>
    	<div id="msg_info"><%=msg==null?"":msg%>&nbsp;&nbsp;<a href="javascript:window.history.back();">返回</a></div>
  	</div>
  </body>
</html>
