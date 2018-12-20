<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.taobao.dao.BulletinDao"%>
<%@page import="com.taobao.util.Pager"%>
<%@page import="com.taobao.entity.Bulletin"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	int pageIndex = request.getParameter("pageIndex") == null ? 1 : Integer.parseInt(request.getParameter("pageIndex"));
	String key = request.getParameter("key") == null ? "" : URLDecoder.decode(request.getParameter("key"),"utf-8");
	BulletinDao dao = new BulletinDao();
	Pager<Bulletin> pager = dao.queryBulletinByPager(pageIndex,key);
	List<Bulletin> list = pager.getList();
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
		var pageIndex = <%=pager.firstPage()%>;
		var url = "<%=basePath%>bulletins.jsp?pageIndex="+pageIndex;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	
	function previous(){
		var pageIndex = <%=pager.previousPage()%>;
		var url = "<%=basePath%>bulletins.jsp?pageIndex="+pageIndex;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	function next(){
		var pageIndex = <%=pager.nextPage()%>;
		var url = "<%=basePath%>bulletins.jsp?pageIndex="+pageIndex;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	function last(){
		var pageIndex = <%=pager.lastPage()%>;
		var url = "<%=basePath%>bulletins.jsp?pageIndex="+pageIndex;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	</script>
	</head>

	<body>&nbsp; 
		<%@ include file="top.jsp"%>
		<div class="details_main1">
			<table width="1240" border="0" cellspacing="0" cellpadding="0"
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
		</div>

		<div class="fenge_10px"></div>
		<table width="1240" border="0" cellspacing="0" cellpadding="0"
			class="table_center">
			<tr>
				<td width="990" valign="top" class="details_border">
					<table border="0" align="center" cellpadding="0" cellspacing="0"
						class="table_center table_border">
						<tr bgcolor="#F6F6F6">
							<td height="40" width="60" align="center" valign="middle"
								class="art_border">
								编号
							</td>
							<td width="730" align="center" valign="middle" class="art_border">
								栏目标题
							</td>
							<td width="200" align="center" valign="middle" class="art_border">
								时间
							</td>
						</tr>
						<%
							for(int i = 0; i < list.size(); i++){
							Bulletin b = list.get(i);
						%>
						<tr class="art_tr">
							<td height="35" width="60" align="center" valign="middle"
								class="art_border">
								<%=b.getId() %>
							</td>
							<td width="730" valign="middle" class="art_border">
								<a href="bulletinDetail.jsp?id=<%=b.getId() %>" class="art_a"><%=b.getTitle() %></a>
							</td>
							<td width="200" align="center" valign="middle" class="art_border">
								<%=b.getCreateTime() %>
							</td>
						</tr>
						<%}%>
					</table>
				</td>
			</tr>
		</table>

		<table width="1240" border="0" cellspacing="0" cellpadding="0"
			align="center" class="table_center">
			<tr>
				<td height="100" align="center" valign="middle">
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
