<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>访问资源出错！</title>
    <link rel="stylesheet" href="common/css/common.css" type="text/css"></link>
    <style type="text/css">
    #error_tip{width:100%;height:80px;line-height:80px;text-align:center;border-bottom:1px dashed #0066CB;font-size:24pt;font-family:'黑体';color:#0066CB;padding-bottom:20px;}
    img.imgop{vertical-align:middle;width:80px;height:80px;}
    #error_info{width:100%;height:200px;padding-top:50px;text-align:left;font-size:10pt;color:#0066CB;}
    #error_info a{color:#EF1D1E;}
    </style>
  </head>
  
  <body>
  	<%@ include file="top.jsp"%>
   	<div id="middle_div">
		<div id="error_tip"><img class="imgop" src="images/error.jpg" />访问资源出错！</div>
	    <%Object msg = request.getAttribute("msg"); %>
	    <div id="error_info"><%=msg==null?"":msg%>&nbsp;&nbsp;<a target="_top" href="<%=basePath%>index.jsp">返回首页</a></div>
    </div>
  	<%@ include file="bottom.jsp"%>
  </body>
</html>
