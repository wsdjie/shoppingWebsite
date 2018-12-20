<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
		<form action="customerServlet" method="post" name="registForm">
		<input type="hidden" name="op" value="regist"/>
		<table width="400" border="0" cellspacing="0" cellpadding="0"
			align="center" class="table_center">
			<tr>
				<td height="80" class="art_show_fonts1" align="center"
					valign="middle">
					一个帐号，玩转所有服务
				</td>
			</tr>
			<%
				if(request.getAttribute("msg") != null){
			%>
			<tr><td colspan="2" align="center"><font color="red" size="5" style="margin-left: 50px;"><%=request.getAttribute("msg") %></font></td></tr>
			<%} %>
			<tr>
				<td height="300">
					<input name="remail" type="text" class="red_email" value=""/>
					<br />
					<input type="password" name="rpwd" class="red_password" value=""/>
					<br />
					<input type="password" name="repwd" class="red_password1" value=""/>
				</td>
			</tr>
			<tr>
				<td height="50">
					<input name="" type="submit" class="login_input" value="新用户立即注册" />
				</td>
			</tr>
			<tr>
				<td height="50" class="main_2_fonts">
					点击“立即注册”，即表示您同意并愿意遵守小米 用户协议 和 隐私政策
				</td>
			</tr>
		</table>
		</form>
		<%@ include file="bottom.jsp"%>
	</body>
</html>
