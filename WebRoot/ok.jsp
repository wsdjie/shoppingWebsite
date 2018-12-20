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
    <link rel="stylesheet" href="common/css/common.css" type="text/css"></link>
    <style type="text/css">
    #msg_tip{width:100%;height:80px;line-height:80px;text-align:center;border-bottom:1px dashed #1F8E1F;font-size:24pt;font-family:'黑体';color:#1F8E1F;padding-bottom:20px;}
    img.imgop{vertical-align:middle;width:80px;height:80px;}
    #msg_info{width:100%;height:200px;padding-top:50px;text-align:left;font-size:10pt;color:#1F8E1F;}
    #msg_info a{color:#EF1D1E;}
    </style>
<link href="css/sp_css.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%@ include file="top.jsp"%>
<div id="middle_div">
    	<div id="msg_tip"><img class="imgop" src="images/ok.png" />操作成功！</div>
    	<%Object msg = request.getAttribute("msg"); %>
    	<div id="msg_info"><%=msg==null?"":msg%>&nbsp;&nbsp;<a target="_top" href="<%=basePath%>index.jsp">返回首页</a></div>
  	</div>
  	<%@ include file="bottom.jsp"%>
  </body>
</html>
