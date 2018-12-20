<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<base href=\""+basePath+"\">");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加商品类型</title>
<link style="text/csss" rel="stylesheet" href="admin/css/add_skin.css">
<link style="text/csss" rel="stylesheet" href="admin/css/common.css">
<style type="text/css">
.name_td{width:100px;}
.btn_td{text-indent:50px;}
</style>
</head>
<body>
<form action="goodsTypeServlet"  method="post">
	<input type="hidden" name="op" value="add"/>
	<div class="opDiv">
			<div class="titlebar">添加商品类型</div>
		</div>
	<table class="addTable">
		<tr>
			<td class="name_td">类型名称:</td>
			<td><input type="text" name="typeName" /></td>
		</tr>
		<tr>
			<td colspan="2" class="btn_td">
				<input class="btn61_21" type="submit" value="提交表单" />&nbsp;&nbsp;
				<input class="btn61_21" type="reset" value="重置表单" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>