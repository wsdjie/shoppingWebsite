<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.taobao.entity.*"%>
<%@page import="com.taobao.dao.*"%>
<%@page import="com.taobao.util.StringUtil"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	request.setCharacterEncoding("utf-8");
	CustomerInfo loginCustomer = null;
	Object obj = session.getAttribute("customer");
	if(obj != null){
		loginCustomer = (CustomerInfo)obj;
	}
	GoodsTypeDao typeDao = new GoodsTypeDao();
	GoodsInfoDao goodsDao = new GoodsInfoDao();
	List<GoodsType> navigateTypeList = typeDao.queryNavigateGoodsType();
	List<GoodsType> allTypeList = typeDao.queryAllGoodsType();
	List<GoodsInfo> recommendGoodsList = goodsDao.queryGoodsForIndex(1);
	List<GoodsInfo> newGoodsList = goodsDao.queryGoodsForIndex(2);
	List<GoodsInfo> welcomeGoodsList = goodsDao.queryGoodsForIndex(3);
	List<GoodsInfo> mostWelcomGoodsList = goodsDao.queryGoodsForIndex(4);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'index.jsp' starting page</title>

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
		<!--登录区域-->
		<center>
		<div class="top">
			<table border="0" cellpadding="0" cellspacing="0"
				class="table_center" align="center">
				<tr>
					<td width="620" height="37" align="left">
						欢迎<%if(loginCustomer != null){%><a href="userOrders.jsp?customerId=<%=loginCustomer.getId()%>&email=<%=loginCustomer.getEmail()%>"><%=loginCustomer.getEmail()%></a><%}%>使用该购物网站，购物愉快！
					</td>
					<td width="620" align="right">
				<a href="login.jsp">重新登录</a>
			</td>
				</tr>
			</table>
		</div>
		</center>
		<!--logo、搜索区域-->
		<div class="search">
			<table width="1240" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td rowspan="2" width="680">
						<img src="images/logo.gif" width="70" height="70" />
					</td>
					<td height="55">

						<table border="0" cellspacing="0" cellpadding="0" align="right">
							<tr>
								<td height="18" width="20">
									<img src="images/ico_1.gif" />
								</td>
								<td style="color: #999999;">
									<a href="bulletins.jsp">网站公告</a>
								</td>
							</tr>
						</table>

					</td>
				</tr>
				<tr>
					<td height="55" valign="top">
					<form action="queryServlet" method="get">
						<input type="text" name="textfield" class="search_txt"
							value="搜索您需要的商品" />
						<input type="submit" name="Submit" value="" class="search_submit" />
						</form>
						<a href="cart.jsp" class="cart_a">购物车</a>
					</td>
				</tr>
			</table>
		</div>
		<!--导航区域-->
		<ul class="menu_ul">
			<li class="menu_li_1">
				全部商品分类
			</li>
			<li class="menu_li_2">
				<a href="javascript:void(0)" class="menu_li_2_a">网站首页</a>
			</li>
			<%
				for(int i = 0; i < navigateTypeList.size(); i++){
				GoodsType type = navigateTypeList.get(i);
			%>
			<li class="menu_li_2">
				<a href="goods.jsp?typeId=<%=type.getTypeId() %>" class="menu_li_2_a"><%=type.getTypeName() %></a>
			</li>
			<%}%>
		</ul>

		<!--商品区域1-->
		<div class="main_1">
			<div class="main_1_left">
				<ul class="classification_ul">
					<%
					for(int i = 0; i < allTypeList.size(); i++){
					GoodsType type = allTypeList.get(i);
					 List<GoodsInfo> goodsList = goodsDao.queryTop3GoodsInfo(type.getTypeId());
				%>
				<li class="aphole_menu_li" onclick="javascript:window.location='goods.jsp?typeId=<%=type.getTypeId() %>'">
					<div class="aphole_menu_li_p_1">
						<%=type.getTypeName() %>
					</div>
					<%
						if(goodsList != null && goodsList.size() > 0){
					%>
					<div class="aphole_menu_li_p_2">
						<%
						for(int j = 0; j < goodsList.size(); j++){
							GoodsInfo goods = goodsList.get(j);
						%>
						<a title="<%=goods.getGoodsName() %>" href="goodsDetail.jsp?goodsId=<%=goods.getGoodsId() %>"><%=StringUtil.omitString(goods.getGoodsName(),10)%></a>&nbsp;
						<%}%>
					</div>
					<%}%>
				</li>
				<%}%>
				</ul>
			</div>
			<div class="main_1_right">
				<div class="barner_1">
					<img alt="产品展示" src="product/product1.jpg" width="991" height="415">
				</div>
				<table border="0" cellspacing="0" cellpadding="0" bgcolor="#F3F3F3">
					<%
						if(mostWelcomGoodsList != null && mostWelcomGoodsList.size() > 0){
					%>
					<tr>
						<%
							for(int i = 0; i < mostWelcomGoodsList.size(); i++){
							GoodsInfo g = mostWelcomGoodsList.get(i);
						%>
						<td width="330" height="36" valign="bottom" class="td_border_1">
							<a href="goodsDetail.jsp?goodsId=<%=g.getGoodsId() %>"><%=g.getGoodsName() %></a>
						</td>
						<%}%>
					</tr>
					<tr>
						<%
							for(int i = 0; i < mostWelcomGoodsList.size(); i++){
							GoodsInfo g = mostWelcomGoodsList.get(i);
						%>
						<td height="25" width="330" class="td_border_2">
							原价：￥<%=g.getPrice() %><%if(g.getDiscount() < 10){%>&nbsp;&nbsp;折后价：<font color="red">￥<%=StringUtil.formatDouble(g.getDiscount()*g.getPrice()/10) %></font><%}%>
						</td>
						<%}%>
					</tr>
					<tr>
						<%
							for(int i = 0; i < mostWelcomGoodsList.size(); i++){
							GoodsInfo g = mostWelcomGoodsList.get(i);
						%>
						<td height="109" width="330" class="td_border_3" align="center"
							valign="bottom">
							<img src="product/<%=g.getPhoto() %>"/>
						</td>
						<%}%>
					</tr>
					<%}%>
				</table>
			</div>
		</div>
		<!--商品区域2-->
		<table border="0" cellspacing="0" cellpadding="0" class="table_center"
			align="center">
			<tr>
				<td width="620" height="60" class="main_2_fonts">
					推荐
				</td>
				<td width="620" height="60" align="right">
					<input value="&lt;" class="main_2_input" name="" type="button" />
					<input value="&gt;" name="" type="button" class="main_2_input" />
				</td>
			</tr>
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0"
			class="table_center table_border">
			<%
				if(recommendGoodsList != null && recommendGoodsList.size() > 0){
			%>
			<tr>
				<%
					for(int i = 0; i < recommendGoodsList.size(); i++){
					GoodsInfo g = recommendGoodsList.get(i);
				%>
				<td width="309" height="240" align="center" valign="middle"
					class="table_border_1">
					<img src="product/<%=g.getPhoto() %>" width="208" height="167" />
				</td>
				<%}%>
			</tr>
			<tr>
				<%
					for(int i = 0; i < recommendGoodsList.size(); i++){
					GoodsInfo g = recommendGoodsList.get(i);
				%>
				<td width="309" height="40" align="center" valign="bottom"
					class="table_border_2">
					<a href="goodsDetail.jsp?goodsId=<%=g.getGoodsId() %>"><%=g.getGoodsName() %></a>
				</td>
				<%}%>
			</tr>
			<tr>
				<%
					for(int i = 0; i < recommendGoodsList.size(); i++){
					GoodsInfo g = recommendGoodsList.get(i);
				%>
				<td width="309" height="30" align="center" valign="middle"
					class="table_border_3">
					原价：￥<%=g.getPrice() %><%if(g.getDiscount() < 10){%>&nbsp;&nbsp;折后价：<font color="red">￥<%=StringUtil.formatDouble(g.getDiscount()*g.getPrice()/10) %></font><%}%>
				</td>
				<%}%>
			</tr>
			<%}%>
		</table>

		<!--商品区域3-->
		<table border="0" cellspacing="0" cellpadding="0" class="table_center"
			align="center">
			<tr>
				<td width="620" height="60" class="main_2_fonts">
					新品上架
				</td>
				<td width="620" height="60" align="right">
					<input value="&lt;" class="main_2_input" name="" type="button" />
					<input value="&gt;" name="" type="button" class="main_2_input" />
				</td>
			</tr>
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0"
			class="table_center table_border">
			<%
				if(newGoodsList != null && newGoodsList.size() > 0){
			%>
			<tr>
				<%
					for(int i = 0; i < newGoodsList.size(); i++){
					GoodsInfo g = newGoodsList.get(i);
				%>
				<td width="309" height="240" align="center" valign="middle"
					class="table_border_1">
					<img src="product/<%=g.getPhoto() %>" width="208" height="167" />
				</td>
				<%}%>
			</tr>
			<tr>
				<%
					for(int i = 0; i < newGoodsList.size(); i++){
					GoodsInfo g = newGoodsList.get(i);
				%>
				<td width="309" height="40" align="center" valign="bottom"
					class="table_border_2">
					<a href="goodsDetail.jsp?goodsId=<%=g.getGoodsId() %>"><%=g.getGoodsName() %></a>
				</td>
				<%}%>
			</tr>
			<tr>
				<%
					for(int i = 0; i < newGoodsList.size(); i++){
					GoodsInfo g = newGoodsList.get(i);
				%>
				<td width="309" height="30" align="center" valign="middle"
					class="table_border_3">
					原价：￥<%=g.getPrice() %><%if(g.getDiscount() < 10){%>&nbsp;&nbsp;折后价：<font color="red">￥<%=StringUtil.formatDouble(g.getDiscount()*g.getPrice()/10) %></font><%}%>
				</td>
				<%}%>
			</tr>
			<%}%>
		</table>
		<!--商品区域4-->
		<table border="0" cellspacing="0" cellpadding="0" class="table_center"
			align="center">
			<tr>
				<td width="620" height="60" class="main_2_fonts">
					大家都喜欢
				</td>
				<td width="620" height="60" align="right">
					<input value="&lt;" class="main_2_input" name="" type="button" />
					<input value="&gt;" name="" type="button" class="main_2_input" />
				</td>
			</tr>
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0"
			class="table_center table_border">
			<%
				if(welcomeGoodsList != null && welcomeGoodsList.size() > 0){
			%>
			<tr>
				<%
					for(int i = 0; i < welcomeGoodsList.size(); i++){
					GoodsInfo g = welcomeGoodsList.get(i);
				%>
				<td width="309" height="240" align="center" valign="middle"
					class="table_border_1">
					<img src="product/<%=g.getPhoto() %>" width="208" height="167" />
				</td>
				<%}%>
			</tr>
			<tr>
				<%
					for(int i = 0; i < welcomeGoodsList.size(); i++){
					GoodsInfo g = welcomeGoodsList.get(i);
				%>
				<td width="309" height="40" align="center" valign="bottom"
					class="table_border_2">
					<a href="goodsDetail.jsp?goodsId=<%=g.getGoodsId() %>"><%=g.getGoodsName() %></a>
				</td>
				<%}%>
			</tr>
			<tr>
				<%
					for(int i = 0; i < welcomeGoodsList.size(); i++){
					GoodsInfo g = welcomeGoodsList.get(i);
				%>
				<td width="309" height="30" align="center" valign="middle"
					class="table_border_3">
					原价：￥<%=g.getPrice() %><%if(g.getDiscount() < 10){%>&nbsp;&nbsp;折后价：<font color="red">￥<%=StringUtil.formatDouble(g.getDiscount()*g.getPrice()/10) %></font><%}%>
				</td>
				<%}%>
			</tr>
			<%}%>
		</table>
		<%@ include file="bottom.jsp"%>
	</body>
</html>
