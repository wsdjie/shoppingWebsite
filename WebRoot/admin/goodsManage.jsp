<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.taobao.dao.GoodsInfoDao"%>
<%@page import="com.taobao.util.Pager"%>
<%@page import="com.taobao.entity.GoodsInfo"%>
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
	GoodsInfoDao dao = new GoodsInfoDao();
	Pager<GoodsInfo> pager = dao.queryGoodsInfoByPager(pageIndex,key);
	List<GoodsInfo> list = pager.getList();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品信息</title>
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

//选择表格中的某个商品
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

function first(){
	var key = document.getElementById("keywords").value;
	var pageIndex = <%=pager.firstPage()%>;
	var url = "<%=basePath%>admin/goodsManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}


function previous(){
	var key = document.getElementById("keywords").value;
	var pageIndex = <%=pager.previousPage()%>;
	var url = "<%=basePath%>admin/goodsManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}

function next(){
	var key = document.getElementById("keywords").value;
	var pageIndex = <%=pager.nextPage()%>;
	var url = "<%=basePath%>admin/goodsManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}

function last(){
	var key = document.getElementById("keywords").value;
	var pageIndex = <%=pager.lastPage()%>;
	var url = "<%=basePath%>admin/goodsManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
}

function search(){
	var key = document.getElementById("keywords").value;
	var pageIndex = 1;
	var url = "<%=basePath%>admin/goodsManage.jsp?pageIndex="+pageIndex+"&key="+key;
	url = encodeURI(encodeURI(url));
	window.location = url;
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
			window.location = "<%=basePath%>goodsInfoServlet?op=delete&ids="+ids;
		}
	}
}

function addGoodsInfo(){
	window.location = "<%=basePath%>admin/addGoods.jsp";
}
</script>
</head>
<body>
	<div class="opDiv">
		<div class="titlebar">商品信息管理</div>
		<div class="buttonDiv">
			<span>
				<input type="text" id="keywords" name="keywords" value="<%=key %>" />
			</span>
			<input class="btn61_21" type="submit" value="查询" onclick="search();"/>
			
			<input class="btn61_21" type="button" onclick="addGoodsInfo();" value="添加商品" />
			<input class="btn61_21" type="button" onclick="deletemultiple();" value="删除商品" />
		</div>
	</div>
	<table id="dataTable">
	<tr>
		<th><input type="checkbox" onclick="chkAll_click();" id="chkAll" /></th>
		<th>商品编号</th>
		<th>商品类别</th>
		<th>商品名称</th>
		<th>商品价格</th>
		<th>商品折扣</th>
		<th>商品图片</th>
		<th>是否新品</th>
		<th>是否推荐</th>
		<th>商品状态</th>
		<th>操作</th>
	</tr>
	<%
		if(list != null && list.size() > 0){
		for(int i = 0; i < list.size(); i++){
			GoodsInfo g = list.get(i);
	%>
	<tr>
		<td align="center">
			<input type="checkbox" name="chkItems" onclick="chkItems_click(this);" value="<%=g.getGoodsId() %>"/>
		</td>
		<td><%=g.getGoodsId() %></td>
		<td><%=g.getTypeName() %></td>
		<td><%=g.getGoodsName() %></td>
		<td>&yen;&nbsp;<%=g.getPrice() %></td>
		<td><%=g.getDiscount() %></td>
		<td><%=g.getPhoto() %></td>
		<td><%=g.getIsNew() == 0 ? "新品" : "非新品" %></td>
		<td><%=g.getIsRecommend() == 0 ? "推荐" : "不推荐" %></td>
		<td><%=g.getStatus()== 0 ? "上架" : "下架" %></td>
		<td align="center">
			<a href="<%=basePath %>admin/updateGoods.jsp?goodsId=<%=g.getGoodsId()%>">修改</a>
			<a href="<%=basePath%>goodsInfoServlet?op=delete&id=<%=g.getGoodsId() %>">删除</a>
		</td>
	</tr>
	<%}} %>
	<tr>
		<td class="pagerTd" colspan="11">
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