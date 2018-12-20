<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.taobao.entity.GoodsType"%>
<%@page import="com.taobao.dao.GoodsTypeDao"%>
<%@page import="com.taobao.util.Pager"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<base href=\""+basePath+"\">");
%>
<%
	int pageIndex = request.getParameter("pageIndex") == null ? 1 : Integer.parseInt(request.getParameter("pageIndex"));
	String key = request.getParameter("key") == null ? "" : URLDecoder.decode(request.getParameter("key"),"utf-8");
	GoodsTypeDao dao = new GoodsTypeDao();
	Pager<GoodsType> pager = dao.queryGoodsTypeByPager(pageIndex,key);
	List<GoodsType> list = pager.getList();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品类型管理</title>
<link style="text/csss" rel="stylesheet" href="admin/css/common.css">
<link style="text/csss" rel="stylesheet" href="admin/css/data_manage.css">
<script type="text/javascript">

//全选/全反选
function chkAll_click(){
	var chkAll = document.getElementById("chkAll");
	var dataTable = document.getElementById("dataTable");
	if(chkAll != null){
		var items = dataTable.getElementsByTagName("input");
		if(items != null){
			for(var i=0;i<items.length;i++){
				if("chkItems" == items[i].name){
					items[i].checked = chkAll.checked;
				}
			}
		}
	}
}

//选择表格中的某个商品类型
function chkItems_click(obj){
	var chkAll = document.getElementById("chkAll");
	var dataTable = document.getElementById("dataTable");
	if(obj!=null && chkAll!=null){
		if(obj.checked){
			chkAll.checked = true;
			return;
		}
		var items = dataTable.getElementsByTagName("input");
		if(items != null){
			for(var i=0;i<items.length;i++){
				if("chkItems"==items[i].name && items[i].checked){
					chkAll.check=true;
					return;
				}
			}
			chkAll.checked = false;
		}
	}
}


function deletemultiple(){
	var chkAll = document.getElementById("chkAll");
	var dataTable = document.getElementById("dataTable");
	var items = dataTable.getElementsByTagName("input");
	var ids = "";
	if(items != null){
		for(var i = 0; i < items.length; i++){
			if(items[i].name == "chkItems" && items[i].checked){
				ids = ids+items[i].value+",";
			}
		}
	}
	if(ids == ""){
		alert("请选择要删除的数据");
	}else{
		if(confirm("确定要删除数据吗？")){
			window.location = "<%=basePath%>goodsTypeServlet?op=delete&ids="+ids;
		}
	}
}

function first(){
	var key = document.getElementById("keywords").value;
	var pageIndex = <%=pager.firstPage()%>;
	var url = "<%=basePath%>admin/goodsTypeManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}


function previous(){
	var key = document.getElementById("keywords").value;
	var pageIndex = <%=pager.previousPage()%>;
	var url = "<%=basePath%>admin/goodsTypeManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}

function next(){
	var key = document.getElementById("keywords").value;
	var pageIndex = <%=pager.nextPage()%>;
	var url = "<%=basePath%>admin/goodsTypeManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}

function last(){
	var key = document.getElementById("keywords").value;
	var pageIndex = <%=pager.lastPage()%>;
	var url = "<%=basePath%>admin/goodsTypeManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}

function search(){
	var key = document.getElementById("keywords").value;
	var pageIndex = 1;
	var url = "<%=basePath%>admin/goodsTypeManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}

function addGoodsType(){
	window.location = "<%=basePath%>admin/addGoodsType.jsp";
}
</script>
</head>
<body>
	<div class="opDiv">
		<div class="titlebar">商品类型管理</div>
		<div class="buttonDiv">
			<span>
				<input type="text" id="keywords" name="keywords" value="<%=key %>" />
			</span>
			<input class="btn61_21" type="submit" value="查询" onclick="search();"/>
			
			<input class="btn61_21" type="button" onclick="addGoodsType();" value="添加类型" />
			<input class="btn61_21" type="button" onclick="deletemultiple();" value="删除类型" />
		</div>
	</div>
	<table id="dataTable">
	<tr>
		<th><input type="checkbox" onclick="chkAll_click();" id="chkAll" /></th>
		<th>类型编号</th>
		<th>类型名称</th>
		<th>操作</th>
	</tr>
	<%
		if(list != null && list.size() > 0){
			for(GoodsType type : list){
	%>
	<tr>
		<td align="center">
			<input type="checkbox" name="chkItems" onclick="chkItems_click(this);" value="<%=type.getTypeId() %>"/>
		</td>
		<td><%=type.getTypeId() %></td>
		<td><%=type.getTypeName() %></td>
		<td align="center">
			<a href="<%=basePath %>admin/updateGoodsType.jsp?typeId=<%=type.getTypeId() %>">修改</a>
			<a href="goodsTypeServlet?op=delete&typeId=<%=type.getTypeId() %>">删除</a>
		</td>
	</tr>
	<%}}%>
	<tr>
		<td class="pagerTd" colspan="4">
			共找到<%=pager.getTotalRecords() %>条记录&nbsp;&nbsp;
			第<%=pager.getPageIndex() %>/<%=pager.getTotalPages() %>页&nbsp;&nbsp;
			<%
				if(pager.isFirst()){
			%>
			首页
			<%}else{%>
			<a href="javascript:first();">首页</a>
			<%} %>
			<%
				if(pager.hasPrevious()){
			%>
			<a href="javascript:previous();">上一页</a>
			<%}else{%>
			上一页
			<%} %>
			<%
				if(pager.hasNext()){
			%>
			<a href="javascript:next();">下一页</a>
			<%}else{%>
			下一页
			<%} %>
			<%
				if(pager.isLast()){
			%>
			尾页
			<%}else{%>
			<a href="javascript:last();">尾页</a>
			<%} %>				
		</td>
	</tr>
	</table>
</body>
</html>