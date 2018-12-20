<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.taobao.dao.BulletinDao"%>
<%@page import="com.taobao.entity.Bulletin"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	BulletinDao dao = new BulletinDao();
	request.setCharacterEncoding("utf-8");
	int id = request.getParameter("id") == null ? 1 : Integer.parseInt(request.getParameter("id"));
	Bulletin b = dao.queryBulletinById(id);
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

	<body>
		<%@ include file="top.jsp"%>
		<div class="details_main1">
			<!--<table width="1240" border="0" cellspacing="0" cellpadding="0"
				class="table_center" align="center">
				<tr>
					<td width="620" height="50" align="left" class="main_2_fonts">
						魅族手机参数【此处放置商品的第一级分类】
					</td>
					<td width="620" height="50" align="right">
						<a href="#" class="shopping_a">立即购买</a>
					</td>
				</tr>
			</table>
		--></div>

		<div class="fenge_10px"></div>
		<table border="0" align="center" width="1240" cellpadding="0"
			cellspacing="0" class="table_center">

			<tr>
				<td width="1240" height="60" colspan="3" align="center"
					valign="middle" class="art_show_fonts1">
					<%=b.getTitle() %>
				</td>
			</tr>
			<tr>
				<td height="60" width="200" align="left" valign="middle"
					class="art_show_fonts2">
					时间：<%=b.getCreateTime() %>
				</td>
				<td width="840" align="left" valign="middle" class="art_show_fonts2">
					来源：<%=b.getUserName() %>
				</td>
				<td width="200" align="right" valign="middle"
					class="art_show_fonts2">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td width="1240" colspan="3" class="art_show_fonts3">
					<%=b.getContent() %>
				</td>
			</tr>
		</table>
		<%@ include file="bottom.jsp"%>
	</body>
</html>
