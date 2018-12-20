<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.taobao.dao.CutomerInfoDao"%>
<%@page import="com.taobao.entity.CustomerInfo"%>
<%@page import="com.taobao.entity.CustomerDetailInfo"%>
<%@page import="com.taobao.entity.CartInfo"%>
<%@page import="com.taobao.entity.OrderDetailInfo"%>
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
	Set<Integer> idSet = null;
	if(session.getAttribute("confirm") == null){
		String[] goodsIds = request.getParameterValues("goodsId");
		idSet = new HashSet<Integer>();
		for(int i = 0; i < goodsIds.length; i++){
			idSet.add(Integer.parseInt(goodsIds[i]));
		}
		session.setAttribute("confirm",idSet);
	}else{
		idSet = (Set<Integer>)session.getAttribute("confirm");
	}
	CutomerInfoDao dao = new CutomerInfoDao();
	//检查客户是否已经登录了
	CustomerInfo customer = session.getAttribute("customer") == null ? null : (CustomerInfo)session.getAttribute("customer");
	//客户的详细信息对象
	CustomerDetailInfo customerDetail = null;
	//获取客户的购物车
	CartInfo cartInfo = (CartInfo)session.getAttribute("cart");
	//判断客户是否登陆
	if(customer == null)
	{
		//如果没有登录就跳回登录页面
		response.sendRedirect(basePath+"login.jsp?pathUrl=confirm.jsp");
	}
	else
	{
		//如果登录检查用户是否有详细信息
		customerDetail = dao.queryCustomerDetailInfoByCustomerId(customer.getId());
		if(customerDetail == null)
		{
			//如果没有就跳到配送信息填写页面
			response.sendRedirect(basePath+"peisong.jsp?pathUrl=confirm.jsp");
		}
	}
	
	//如果用户登录了也有详细信息直接查询出详细信息填写在表格中
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单确认-千里之行，在线销售旅游产品</title>
<link rel="stylesheet" href="common/css/common.css" type="text/css"></link>
<style type="text/css">
div.title{text-align:center;font-size:14pt;font-family:'黑体';height:28px;line-height:28px;margin:5px;}
div.title span{font-family:'华文行楷','楷体','黑体';font-size:18pt;margin-right:3px;}

div.item_title{text-align:left;margin-top:3px;border:1px solid #ccc;color:#000;font-size:10pt;background:url(images/item.gif) no-repeat 3px 7px #E6F0F9;height:28px;line-height:28px;text-indent:15px;}
div.item_content{text-align:center;padding:10px 0px 10px 0px;border:1px solid #ccc;border-top-width:0px;}

table.tb_info {border:1px solid #ccc;border-collapse:collapse;width:960px;text-align:left;color:#484848;font-size:11pt;}
table.tb_info td{height:30px;line-height:30px;border:1px solid #ccc;text-indent:1em;}
table.tb_info th{height:30px;line-height:30px;border:1px solid #ccc;}
table.tb_info td.title{width:120px;text-align:left;background-color:#F6F6F6;}

table.tb_info th{font-size:11pt;height:24px;line-height:24px;background-color:#F6F6F6;text-align:center;}
.goodsImg{width:50px;height:50px;float:left;margin:3px;}
.goodsName{float:left;height:50px;line-height:50px;}
td.sum span{font-size:18pt;font-family:Georgia,'Times new roman,serif';color:#FF6600;font-weight:bold;}

div.op{height:40px;line-height:40px;text-align:center;}
.btn61_21 {width:61px;height:21px;vertical-align:middle;line-height:21px;border-width: 0px;border-style:none;padding: 0px;font-size:12px;margin-right: 3px;background: url(images/btn.png) no-repeat 0 0;cursor: pointer;}
</style>
<link href="css/sp_css.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%@ include file="top.jsp"%>
<div id="middle_div" style="width: 1240px; margin-left: auto; margin-right: auto;">
	<!--<div class="sitemap">
		您现在所在的位置：<a target="_top" href="index.jsp">网站首页</a>&nbsp;&gt;&nbsp;
		<a target="_top" href="cart.jsp">购物车</a>&nbsp;&gt;&nbsp;订单确认
	</div>
	
	--><div class="title"><span>足下币</span>购物订单确认表</div>
	<%
		//if(customer != null && customerDetail != null)
		//{
	%>
	<div>
		<div class="item_title">客户信息</div>
		<div class="item_content">
			<table align="center" class="tb_info">
				<tr>
					<td class="title">客户编号</td>
					<td><%=customer.getId() %></td>
					<td class="title">注册时间</td>
					<td><%=customer.getRegisterTime() %></td>
				</tr>
				<tr>
					<td class="title">客户账户/邮箱</td>
					<td><%=customer.getEmail() %></td>
					<td class="title">收货人姓名</td>
					<td><%=customerDetail.getName() %></td>
				</tr>
				<tr>
					<td class="title">固定电话</td>
					<td><%=customerDetail.getTelphone() %></td>
					<td class="title">移动电话</td>
					<td><%=customerDetail.getMovePhone() %></td>
				</tr>
				<tr>
					<td class="title">收货地址</td>
					<td colspan="3"><%=customerDetail.getAddress() %></td>
				</tr>
			</table>
		</div>
		<div class="item_title">订单信息</div>
		<%
			if(cartInfo != null)
			{
		%>
		<div class="item_content">
			<table align="center"  class="tb_info">
				<tr>
					<th>编号</th>
					<th>商品名称</th>
					<th>商品类型</th>
					<th>价格</th>
					<th>折扣</th>
					<th>数量</th>
					<th>小计</th>
				</tr>
				<%
					for(Integer key : idSet)
					{
					OrderDetailInfo orderDetailInfo = cartInfo.getCart().get(key);
				%>
				<tr>
					<td></td>
					<td>
						<img class="goodsImg" src="product/<%=orderDetailInfo.getPhoto()%>">
						<div class="goodsName"><%=orderDetailInfo.getGoodsName()%></div>
					</td>
					<td>
						<%=orderDetailInfo.getTypeName()%>
					</td>
					<td>
						<%=orderDetailInfo.getPrice() %>元
					</td>
					<td>
						<%=orderDetailInfo.getDiscount() %>
					</td>
					<td align="center">
						<%=orderDetailInfo.getQuantity() %>
					</td>
					<td>
						<%=orderDetailInfo.subTotalPrice() %>元
					</td>
				</tr>
				<%}%>
				<tr>
					<td colspan="7" class="sum">
						此订单中共有<span><%=cartInfo.getCart().size() %></span>件商品，总计金额<span><%=cartInfo.totalPrice() %></span>元！
					</td>
				</tr>
			</table>
		</div>
		<%}%>
	</div>
	<%//}%>
	<div class="op">
		<form action="orderServlet?op=confirm" method="post">
			<input type="submit" class="btn61_21" value="确认订单" />&nbsp;&nbsp;
			<input type="button" onclick="window.top.location.href='<%=basePath%>cart.jsp'" class="btn61_21" value="返&nbsp;回" />
		</form>
	</div>
</div>
<%@ include file="bottom.jsp"%>
</body>
</html>