<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.taobao.entity.CartInfo"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.taobao.entity.OrderDetailInfo"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	CartInfo cartInfo = session.getAttribute("cart") == null ? null : (CartInfo)session.getAttribute("cart");
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
		function changeQuantity(flag,goodsId){
			window.location = "cartServlet?op=changeQuantity&flag="+flag+"&goodsId="+goodsId;
		}
		function checkOut(){
			var table = document.getElementById("cartTable");
			var chs = table.getElementsByTagName("input");
			var check = false;
			for(var i = 0; i < chs.length; i++){
				if(chs[i].name=="goodsId" && chs[i].checked){
					check = true;
				}
			}
			if(check){
				document.cartForm.submit();
			}else{
				alert("请选择要下单的商品！");
			}

		}
	</script>
	</head>

	<body>
		<%@ include file="top.jsp"%>
		<div class="details_main1">
			<table width="1240" border="0" cellspacing="0" cellpadding="0"
				class="table_center" align="center">
				<tr>
					<td width="620" height="50" align="left" class="cart_fonts1">
						全部商品<%=cartInfo==null?0 : cartInfo.getCart().size()%>件
					</td>
					<td width="475" height="50" align="right" class="cart_fonts1">
						总计：￥<%=cartInfo==null?0.00 : cartInfo.totalPrice()%>
					</td>
					<td width="145" align="right">
						<a href="javascript:checkOut();" class="shopping_a">立即结算</a>
					</td>
				</tr>
			</table>
		</div>

		<div class="fenge_10px"></div>
		<form action="confirm.jsp" name="cartForm" method="post">
		<table border="0" align="center" cellpadding="0" cellspacing="0"
			class="table_center table_border" id="cartTable">
			<%
				if(cartInfo == null || cartInfo.getCart().isEmpty()){
			%>
				<tr class="art_tr"><td colspan="7" align="center" style="font-size: 20px;">购物车是空的呢！<a href="index.jsp" style="font-size: 20px;">马上去购物&gt;&gt;&gt;</a></td></tr>
			<%
				}else{
			%>
			<tr bgcolor="#F6F6F6">
				<td height="40" width="61" align="center" valign="middle"
					class="art_border">
					<input type="checkbox" name="checkbox" value="checkbox" id="chkAll"/>
					全选
				</td>
				<td colspan="2" align="center" valign="middle" class="art_border">
					商品信息
				</td>
				<td width="101" align="center" valign="middle" class="art_border">
					单价（元）
				</td>
				<td width="201" align="center" valign="middle" class="art_border">
					数量
				</td>
				<td width="101" align="center" valign="middle" class="art_border">
					金额（元）
				</td>
				<td width="101" align="center" valign="middle" class="art_border">
					操作（<a href="cartServlet?op=clear" class="art_a">清空</a>）
				</td>
			</tr>
			<%
				for(Map.Entry<Integer,OrderDetailInfo> entry : cartInfo.getCart().entrySet()){
				OrderDetailInfo orderDetail = entry.getValue();
			%>
			<tr class="art_tr">
				<td height="140" width="60" align="center" valign="middle"
					class="art_border">
					<input type="checkbox" name="goodsId" value="<%=orderDetail.getGoodsId() %>" />
				</td>
				<td width="180" align="center" valign="middle" class="art_border">
					<img src="product/<%=orderDetail.getPhoto() %>" height="130" width="170" />
				</td>
				<td width="490" valign="top" class="cart_fonts2">
					<%=orderDetail.getTypeName() %>&nbsp;&nbsp;<%=orderDetail.getGoodsName() %>
				</td>
				<td width="90" align="center" valign="middle" class="cart_fonts2">
					<%=orderDetail.getBuyPrice() %>元
				</td>
				<td width="200" align="center" valign="middle" class="art_border">
					<input name="" type="button" value="-" class="main_2_input" onclick="changeQuantity(0,<%=orderDetail.getGoodsId()%>)"/>
					<input name="quantity<%=orderDetail.getGoodsId()%>" type="text" value="<%=orderDetail.getQuantity() %>" class="main_2_txt" />
					<input name="" type="button" value="+" class="main_2_input" onclick="changeQuantity(1,<%=orderDetail.getGoodsId()%>)"/>
				</td>
				<td width="100" align="center" valign="middle" class="art_border">
					<%=orderDetail.subTotalPrice() %>元
				</td>
				<td width="100" align="center" valign="middle" class="art_border">
					<a href="cartServlet?op=delete&goodsId=<%=orderDetail.getGoodsId() %>" class="art_a">删除</a>
				</td>
			</tr>
			<%}} %>
		</table>
		</form>
		<table width="1240" border="0" cellspacing="0" cellpadding="0" class="table_center" align="center" style="margin-top: 30px;">
		  <tr>
		    <td width="1240" align="right"><a href="index.jsp" class="shopping_a">继续购物</a></td>
		  </tr>
		</table>
		<%@ include file="bottom.jsp"%>
	</body>
</html>
