<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.taobao.util.Pager"%>
<%@page import="com.taobao.entity.GoodsInfo"%>
<%@page import="com.taobao.dao.GoodsInfoDao"%>
<%@page import="com.taobao.util.StringUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	int pageIndex = request.getParameter("pageIndex") == null ? 1 : Integer.parseInt(request.getParameter("pageIndex"));
	int typeId = request.getParameter("typeId") == null ? 1 : Integer.parseInt(request.getParameter("typeId"));
	GoodsInfoDao dao = new GoodsInfoDao();
	Pager<GoodsInfo> pager = dao.queryGoodsInfoByPager(pageIndex,typeId);
	List<GoodsInfo> list = pager.getList();
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
	<script type="text/javascript">
			
	function first(){
		var typeId = document.getElementById("typeId").value;
		var pageIndex = <%=pager.firstPage()%>;
		var url = "<%=basePath%>goods.jsp?pageIndex="+pageIndex+"&typeId="+typeId;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	
	function previous(){
		var typeId = document.getElementById("typeId").value;
		var pageIndex = <%=pager.previousPage()%>;
		var url = "<%=basePath%>goods.jsp?pageIndex="+pageIndex+"&typeId="+typeId;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	function next(){
		var typeId = document.getElementById("typeId").value;
		var pageIndex = <%=pager.nextPage()%>;
		var url = "<%=basePath%>goods.jsp?pageIndex="+pageIndex+"&typeId="+typeId;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	function last(){
		var typeId = document.getElementById("typeId").value;
		var pageIndex = <%=pager.lastPage()%>;
		var url = "<%=basePath%>goods.jsp?pageIndex="+pageIndex+"&typeId="+typeId;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	</script>
	</head>

	<body>
		<%@ include file="top.jsp"%>
		<div class="details_main1">
			<table width="1240" border="0" cellspacing="0" cellpadding="0"
				class="table_center">
				<tr>
					<td width="620" height="50" align="left" class="main_2_fonts">
						魅族手机参数【此处放置商品的第一级分类】
					</td>
					<td width="620" height="50" align="right">
						<a href="#" class="shopping_a">立即购买</a>
					</td>
				</tr>
			</table>
		</div>

		<div class="fenge_10px"></div>
		<table border="0" align="center" cellpadding="0" cellspacing="0"
			class="table_center table_border">
			<tr>
				<%
					for(int i = 0; i < list.size(); i++){
					GoodsInfo g = list.get(i);
				%>
				<td width="309" align="center" valign="bottom" class="shop_border">
					<img src="product/<%=g.getPhoto() %>" width="280" height="250" />
					<br />
					<a href="goodsDetail.jsp?goodsId=<%=g.getGoodsId() %>"><%=g.getGoodsName() %></a>
					<br />
					原价：￥<%=g.getPrice() %><%if(g.getDiscount() < 10){%>&nbsp;&nbsp;折后价：<font color="red">￥<%=StringUtil.formatDouble(g.getDiscount()*g.getPrice()/10) %></font><%}%>
				</td>
				<%
				if((i+1) % 4 == 0){
				%>
				</tr><tr>
				<%
				}}
				%>
		</table>

		<table width="1240" border="0" cellspacing="0" cellpadding="0"
			align="center" class="table_center">
			<tr>
				<td height="100" align="center" valign="middle">
					<input type="hidden" id="typeId" value="<%=typeId %>"/>
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
		<%@ include file="bottom.jsp"%>
	</body>
</html>
