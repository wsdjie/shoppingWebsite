<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.taobao.dao.OrderInfoDao"%>
<%@page import="com.taobao.util.Pager"%>
<%@page import="com.taobao.entity.OrderViewInfo"%>
<%@page import="com.taobao.entity.OrderDetailInfo"%>
<%@page import="com.taobao.util.StringUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	request.setCharacterEncoding("utf-8");
	int customerId = Integer.parseInt(request.getParameter("customerId"));
	String email = request.getParameter("email");
	int pageIndex = request.getParameter("pageIndex") == null ? 1: Integer.parseInt(request.getParameter("pageIndex"));
	OrderInfoDao dao = new OrderInfoDao();
	Pager<OrderViewInfo> pager = dao.queryOderViewByPager(pageIndex, customerId);
	//List<OrderViewInfo> list = pager.getList();
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
		var customerId = document.getElementById("customerId").value;
		var pageIndex = <%=pager.firstPage()%>;
		var url = "<%=basePath%>admin/orderManage.jsp?pageIndex="+pageIndex+"&customerId"+customerId;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	
	function previous(){
		var customerId = document.getElementById("customerId").value;
		var pageIndex = <%=pager.previousPage()%>;
		var url = "<%=basePath%>admin/orderManage.jsp?pageIndex="+pageIndex+"&customerId"+customerId;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	function next(){
		var customerId = document.getElementById("customerId").value;
		var pageIndex = <%=pager.nextPage()%>;
		var url = "<%=basePath%>admin/orderManage.jsp?pageIndex="+pageIndex+"&customerId"+customerId;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	
	function last(){
		var customerId = document.getElementById("customerId").value;
		var pageIndex = <%=pager.lastPage()%>;
		var url = "<%=basePath%>admin/orderManage.jsp?pageIndex="+pageIndex+"&customerId"+customerId;
		url = encodeURI(encodeURI(url));
		window.location = url;
	}
	</script>
	</head>
	<body>

		<!--登录区域-->
		<div class="top">
			<table border="0" cellpadding="0" cellspacing="0"
				class="table_center" align="center">
				<tr>
					<td width="620" height="37" align="left">
						欢迎【<%=email %>】使用该购物网站，购物愉快！
					</td>
					<td width="620" align="right">
						<a href="login.jsp">登录</a>｜
						<a href="register.jsp">注册</a>
					</td>
				</tr>
			</table>
		</div>
		<!--logo、搜索区域-->





		<div class="details_main1">
			<table width="1240" border="0" cellspacing="0" cellpadding="0"
				class="table_center" align="center">
				<tr>
					<td width="620" height="50" align="left" class="cart_fonts1">
						<a href="javascript:void(0)" class="cart_fonts1">所有订单</a>
						<a href="javascript:void(0)" class="cart_fonts1">待付款</a>
						<a href="javascript:void(0)" class="cart_fonts1">待发货</a>
						<a href="javascript:void(0)" class="cart_fonts1">待收货</a>
						<a href="javascript:void(0)" class="cart_fonts1">待评价</a>
					</td>
					<td width="475" height="50" align="right" class="cart_fonts1"></td>
					<td width="145" align="right">
						<a href="javascript:void(0)" class="shopping_a">订单回收站</a>
					</td>
				</tr>
			</table>
		</div>

		<div class="fenge_10px"><input type="hidden" value="<%=customerId %>" id="customerId"/></div>
		<table border="0" align="center" cellpadding="0" cellspacing="0"
			class="table_center table_border">
			<%
			if(pager != null && pager.getList().size() > 0){
			for(int i = 0; i < pager.getList().size(); i++){
			OrderViewInfo order = pager.getList().get(i);
			List<OrderDetailInfo> detailList = dao.queryOrderDetailByOrderId(order.getOrderId());
			double totalPrice = 0;
			for(int j = 0; j < detailList.size(); j++){totalPrice += detailList.get(j).subTotalPrice();}
			%>
			<tr bgcolor="#DEFAD8">
				<td height="40" width="61" align="center" valign="middle"
					class="art_border">
					<input type="checkbox" name="checkbox" value="checkbox" />
				</td>
				<td colspan="2" align="left" valign="middle" class="art_border">
					<%=order.getOrderTime() %> 订单号：<%=order.getOrderId() %>
				</td>
				<td width="101" align="center" valign="middle" class="art_border">
					金额（元）
				</td>
				<td width="201" align="center" valign="middle" class="art_border">
					数量
				</td>
				<td colspan="2" align="right" valign="middle"
					class="art_border cart_fonts2">
					该订单总金额：<%=StringUtil.formatDouble(totalPrice) %>元
				</td>
			</tr>
			<%
			for(int j = 0; j < detailList.size(); j++){
			OrderDetailInfo detail = detailList.get(j);
			%>
			<tr>
				<td height="140" width="61" align="center" valign="middle"
					class="art_border">
					<a href="goodsDetail.jsp?goodsId=<%=detail.getGoodsId()%>"></a>
				</td>
				<td width="180" align="center" valign="middle" class="art_border">
					<img src="product/<%=detail.getPhoto() %>" height="130" width="170" />
				</td>
				<td width="490" valign="top" class="cart_fonts2">
					<%=detail.getTypeName() %>&nbsp;&nbsp;<%=detail.getGoodsName() %>&nbsp;&nbsp;<%if(detail.getDiscount() < 10){ %><%=detail.getDiscount()%>折！<%} %>
				</td>
				<td width="101" align="center" valign="middle" class="cart_fonts2">
					<%=detail.getBuyPrice() %>元
				</td>
				<td width="201" align="center" valign="middle" class="art_border">
					<%=detail.getQuantity() %>
				</td>
				<td width="101" align="center" valign="middle" class="art_border">
					<a href="javascript:void(0)" class="art_a">确认收货</a>
					<br />
					<br />
					<a href="javascript:void(0)" class="art_a">查看物流</a>
				</td>
				<td width="101" align="center" valign="middle" class="art_border">
					<a href="javascript:void(0)" class="art_a">退货/退款</a>
				</td>
			</tr>
			<%}}} %>
		</table>


		<table border="0" cellspacing="0" cellpadding="0" class="table_center"
			align="center">
			<tr>
				<td height="100" width="120" align="left" valign="middle"
					class="main_2_fonts">
					<input type="checkbox" name="checkbox" value="checkbox" />
					全选
				</td>
				<td height="100" width="120" align="left" valign="middle">
					<a href="javascript:void(0)" class="main_2_fonts">全选删除</a>
				</td>
				<td height="100" width="1000" align="right" valign="middle">
					共找到<%=pager.getTotalRecords()%>条记录&nbsp;&nbsp; 第<%=pager.getPageIndex()%>/<%=pager.getTotalPages()%>页&nbsp;&nbsp;
					<%
						if (pager.isFirst()) {
					%>
					首页
					<%
						} else {
					%>
					<a href="javascript:first();">首页</a>
					<%
						}
					%>
					<%
						if (pager.hasPrevious()) {
					%>
					<a href="javascript:previous();">上一页</a>
					<%
						} else {
					%>
					上一页
					<%
						}
					%>
					<%
						if (pager.hasNext()) {
					%>
					<a href="javascript:next();">下一页</a>
					<%
						} else {
					%>
					下一页
					<%
						}
					%>
					<%
						if (pager.isLast()) {
					%>
					尾页
					<%
						} else {
					%>
					<a href="javascript:last();">尾页</a>
					<%
						}
					%>
				</td>
			</tr>
		</table>
		<%@ include file="bottom.jsp"%>
	</body>
</html>
