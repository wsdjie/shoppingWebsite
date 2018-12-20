<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.taobao.dao.GoodsTypeDao"%>
<%@page import="com.taobao.entity.GoodsType"%>

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
int typeId = request.getParameter("typeId") == null  ? 0 : Integer.parseInt(request.getParameter("typeId"));
GoodsTypeDao dao = new GoodsTypeDao();
GoodsType type = dao.queryGoodsTypeId(typeId); 
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看/修改商品类型信息</title>
<link style="text/csss" rel="stylesheet" href="admin/css/add_skin.css">
<link style="text/csss" rel="stylesheet" href="admin/css/common.css">
<style type="text/css">
.name_td{width:100px;}
.btn_td{text-indent:50px;}
#number_span{padding:3px 10px 3px 10px;font-size:120%;border:1px solid #ADAEB0;background-color:#fff;color:#ADAEB0;font-weight:bold;}
</style>
</head>
<body>
<form action="goodsTypeServlet" method="post">
	<input type="hidden" name="op" value="update"/>
	<input type="hidden" name="typeId" value="<%=type.getTypeId() %>" />
	<div class="opDiv">
			<div class="titlebar">查看/修改商品类型信息</div>
	</div>
	<table class="addTable">
		<tr>
			<td class="name_td">类型编号:</td>
			<td>
				<span id="number_span"><%=type.getTypeId() %></span>
			</td>
		</tr>
		<tr>
			<td class="name_td">类型名称:</td>
			<td><input type="text" name="typeName" value="<%=type.getTypeName() %>" /></td>
		</tr>
		<tr>
			<td colspan="2" class="btn_td">
				<input class="btn61_21" type="submit" value="提交表单" />&nbsp;&nbsp;
				<input class="btn61_21" type="reset" value="重置表单" />&nbsp;&nbsp;
				<input class="btn61_21" type="button" onclick="window.history.go(-1);" value="返回" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>