<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setCharacterEncoding("utf-8");
	String pathUrl = request.getParameter("pathUrl") == null ? "" : request.getParameter("pathUrl");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'bulletins.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link href="css/sp_css.css" rel="stylesheet" type="text/css" />
	</head>

	<body bgcolor="#FAFAFA">
		<!--logo、搜索区域-->
		<div class="search">
			<table width="1240" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" height="110">
						<img src="images/logo.gif" width="70" height="70" />
					</td>
				</tr>
			</table>
		</div>

		<div class="fenge_10px"></div>
		<form action="customerServlet" method="post">
		<input type="hidden" name="op" value="login"/>
		<input type="hidden" name="pathUrl" value="<%=pathUrl%>"/>
		<table width="400" border="0" cellspacing="0" cellpadding="0"
			align="center" class="table_center">
			<tr>
				<td height="80" class="art_show_fonts1" align="center"
					valign="middle">
					一个帐号，玩转所有服务
				</td>
			</tr>
			<tr>
				<td height="150" align="left">
					<input name="email" type="text" class="login_user" />
					<%
						if(request.getAttribute("msg") != null){
					%>
					<font color="red" size="5" style="margin-left: 50px;"><%=request.getAttribute("msg") %></font>
					<%
					}
					%>
					<br/>
					<input type="password" name="pwd" class="login_password" />
				</td>
			</tr>
			<tr>
				<td height="50">
					<input name="" type="submit" class="login_input" value="用户登录" />
				</td>
			</tr>
			<tr>
				<td height="50" valign="middle" align="right">
					其它方式登录|忘记密码？
				</td>
			</tr>
			<tr>
				<td height="50">
					<a href="register.jsp" class="login_input1">注册平台帐号</a>
				</td>
			</tr>

		</table>
		</form>
		<%@ include file="bottom.jsp"%>
	</body>
</html>
