<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.taobao.dao.BulletinDao"%>
<%@page import="com.taobao.entity.Bulletin"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<base href=\""+basePath+"\">");
%>
<%
	request.setCharacterEncoding("utf-8");
	int id = request.getParameter("id") == null ? 0 : Integer.parseInt(request.getParameter("id"));
	BulletinDao dao = new BulletinDao();
	Bulletin b = dao.queryBulletinById(id);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看/修改公告信息</title>
<link style="text/csss" rel="stylesheet" href="admin/css/add_skin.css">
<link style="text/csss" rel="stylesheet" href="admin/css/common.css">
<style type="text/css">
.name_td{width:100px;}
.long_inputbox{width:500px;}
#number_span{padding:3px 10px 3px 10px;font-size:120%;border:1px solid #ADAEB0;background-color:#fff;color:#ADAEB0;font-weight:bold;}
</style>
</head>
<body>
<form action="bulletinServlet" method="post">
	<input type="hidden" name="op" value="update"/>
	<input type="hidden" name="id" value="<%=b.getId() %>" />
	<div class="opDiv">
			<div class="titlebar">查看/修改公告信息</div>
	</div>
	<table class="addTable">
		<tr>
			<td class="name_td">编号:</td>
			<td>
				<span id="number_span"><%=b.getId() %></span>
			</td>
		</tr>
		<tr>
			<td class="name_td">标题:</td>
			<td><input type="text" class="long_inputbox" name="title" value="<%=b.getTitle() %>" /></td>
		</tr>
		<tr>
			<td class="name_td">内容:</td>
			<td>
				
				<textarea name="content" rows="10" cols="80"><%=b.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<td class="name_td">发布者:</td>
			<td><%=b.getUserName() %></td>
		</tr>
		<tr>
			<td class="name_td">发布时间:</td>
			<td><%=b.getCreateTime() %></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<input class="btn61_21" type="submit" value="提交表单" />&nbsp;&nbsp;
				<input class="btn61_21" type="reset" value="重置表单" />&nbsp;&nbsp;
				<input class="btn61_21" type="button" onclick="window.history.go(-1);" value="返回" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>