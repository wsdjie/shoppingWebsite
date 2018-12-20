<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.taobao.entity.CustomerInfo"%>
<%@page import="com.taobao.dao.GoodsTypeDao"%>
<%@page import="com.taobao.entity.GoodsType"%>
<%@page import="com.taobao.dao.GoodsInfoDao"%>
<%@page import="com.taobao.entity.GoodsInfo"%>
<%@page import="com.taobao.util.StringUtil"%>
<%
	request.setCharacterEncoding("utf-8");
	CustomerInfo loginCustomer = null;
	Object obj = session.getAttribute("loginCustomer");
	if(obj != null){
		loginCustomer = (CustomerInfo)obj;
	}
	GoodsTypeDao typeDao = new GoodsTypeDao();
	GoodsInfoDao goodsDao = new GoodsInfoDao();
	List<GoodsType> navigateTypeList = typeDao.queryNavigateGoodsType();
	List<GoodsType> allTypeList = typeDao.queryAllGoodsType();
%>
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
<ul class="menu_ul">
	<li class="menu_li_1">
		全部商品分类
		<div class="aphole_menu">
			<ul class="aphole_menu_ul">
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
	</li>
	<li class="menu_li_2">
		<a href="index.jsp" class="menu_li_2_a">网站首页</a>
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