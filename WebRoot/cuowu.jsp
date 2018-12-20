<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>操作失败！</title>
		<link rel="stylesheet" href="common/css/common.css" type="text/css"></link>
		<style type="text/css">
#error_tip {
	width: 100%;
	height: 80px;
	line-height: 80px;
	text-align: center;
	border-bottom: 1px dashed #EF1D1E;
	font-size: 24pt;
	font-family: '黑体';
	color: #EF1D1E;
	padding-bottom: 20px;
}

img {
	vertical-align: middle;
}

#error_info {
	width: 100%;
	height: 200px;
	padding-top: 50px;
	text-align: left;
	font-size: 10pt;
	color: #EF1D1E;
}

#error_info a {
	color: #1F8E1F;
}
</style>
		<link href="css/sp_css.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<%@ include file="top.jsp"%>
		<div id="middle_div">
			<div id="error_tip">
				<img src="images/error.gif" />
				操作失败！
			</div>
			<%
				Object msg = request.getAttribute("msg");
			%>
			<div id="error_info"><%=msg == null ? "" : msg%>&nbsp;&nbsp;
				<a target="_top" href="<%=basePath%>peisong.jsp?pathUrl=confirm.jsp">返回上一页</a>
			</div>
		</div>
		<%@ include file="bottom.jsp"%>
	</body>
</html>

