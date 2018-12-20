<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.taobao.dao.OrderInfoDao"%>
<%@page import="com.taobao.entity.OrderViewInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.taobao.entity.OrderDetailInfo"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<base href=\""+basePath+"\">");
%>
<%
	OrderInfoDao orderDao = new OrderInfoDao();
	int orderId = Integer.parseInt(request.getParameter("orderId")); 
	OrderViewInfo orderViewInfo = orderDao.queryOrderViewInfoByOrderId(orderId);
	List<OrderDetailInfo> list = orderDao.queryOrderDetailByOrderId(orderId);
	double totalPrice = 0;
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>显示订单详细信息</title>
<link style="text/csss" rel="stylesheet" href="admin/css/add_skin.css">
<link style="text/csss" rel="stylesheet" href="admin/css/data_manage.css">
<link style="text/csss" rel="stylesheet" href="admin/css/common.css">
<style type="text/css">
.name_td{width:120px;}
.addTable td{height:10px;}
#dataTable_div{height:200px;overflow-y:scroll;border-bottom:1px dashed #CBCCCE;}
</style>
</head>
<body>
	<div class="opDiv">
		<div class="titlebar">(订单详细信息</div>
	</div>
	<table class="addTable">
		<tr>
			<td class="name_td">订单编号:</td>
			<td><%=orderViewInfo.getOrderId() %></td>
			<td class="name_td">订单状态:</td>
			<td><%=orderViewInfo.getStatus() == 0 ? "未确认" : "已确认" %></td>
			<td class="name_td">下单时间:</td>
			<td colspan="3"><%=orderViewInfo.getRegisterTime() %></td>
		</tr>
		<tr>
			<td class="name_td">客户编号:</td>
			<td><%=orderViewInfo.getCustomerId() %></td>
			<td class="name_td">客户账户/邮箱:</td>
			<td>
				<a href="javascript:void(0);"><%=orderViewInfo.getEmail() %></a>
			</td>
			<td class="name_td">注册时间:</td>
			<td><%=orderViewInfo.getRegisterTime() %></td>
		</tr>
		<tr>
			<td class="name_td">收货人姓名:</td>
			<td><%=orderViewInfo.getName() %></td>
			<td class="name_td">固定电话:</td>
			<td><%=orderViewInfo.getTelphone() %></td>
			<td class="name_td">移动电话:</td>
			<td><%=orderViewInfo.getMovePhone() %></td>
		</tr>
		<tr>
			<td class="name_td">收货地址:</td>
			<td colspan="5"><%=orderViewInfo.getAddress() %></td>
		</tr>
	</table>
	<div id="dataTable_div">
		<table id="dataTable">
			<tr>
				<th>商品编号</th>
				<th>商品类别</th>
				<th>商品名称</th>
				<th>商品价格</th>
				<th>商品折扣</th>
				<th>订购数量</th>
				<th>小计</th>
			</tr>
			<%
				if(list != null && list.size() > 0){
					for(int i = 0; i < list.size(); i++){
						OrderDetailInfo orderDetail = list.get(i);
						totalPrice += orderDetail.subTotalPrice();
			%>
			<tr>
				<td><%=orderDetail.getGoodsId() %></td>
				<td>
					<a href="javascript:void(0);"><%=orderDetail.getTypeName() %></a>
				</td>
				<td>
					<a href="javascript:void(0);"><%=orderDetail.getGoodsName() %></a>
				</td>
				<td>&yen;<%=orderDetail.getPrice() %></td>
				<td><%=orderDetail.getDiscount() %></td>
				<td><%=orderDetail.getQuantity() %></td>
				<td><%=orderDetail.subTotalPrice() %></td>
			</tr>
			<%}} %>
			<tr>
				<td>总金额：</td>
				<td colspan="6">&yen;&nbsp;<%=new DecimalFormat("0.00").format(totalPrice) %></td>
			</tr>
		</table>
	</div>
	<div style="margin-top:20px;padding-right:20px;text-align: right;">
		<input class="btn61_21" type="button" onclick="window.history.back();" value="返回" />
	</div>
</body>
</html>