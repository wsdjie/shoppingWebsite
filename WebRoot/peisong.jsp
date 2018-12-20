<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<base href=\""+basePath+"\">");
request.setCharacterEncoding("utf-8");
String pathUrl = request.getParameter("pathUrl");
CustomerInfo customer = (CustomerInfo)session.getAttribute("customer");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>填写配送信息-千里之行-在线销售旅游产品</title>
<link href="css/sp_css.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	table.tb_info{width:100%;}
	.title{background:url(images/peisong_logo.gif) no-repeat 0px center;border-bottom:1px solid #9999FF;height:30px;line-height:38px;font-size:12pt;color:#2F85EF;text-indent:30px;font-weight:bold;}
	table.tb_info .input_box{width:140px;height:18px;vertical-align:center;}
	table.tb_info .input_box_long{width:350px;height:18px;vertical-align:center;}
	table.tb_info td{height:35px;border-bottom:1px dashed #ccc;padding:3px;}
	table.tb_info .tooltip{font-size:9pt;color:#999;font-weight:normal;padding-left:5px;white-space:nowrap;}
	.btn61_21 {width:61px;height: 21px;line-height:21px;border-width: 0px;border-style:none;padding: 0px;font-size:12px;margin-right: 3px;background: url(images/btn.png) no-repeat 0 0;cursor: pointer;}
</style>
</head>
<body>
<%@ include file="top.jsp"%>
<div id="middle_div" style="width: 1240px; margin-left: auto; margin-right: auto;">
	<div class="title">填写配送信息</div>
	<form action="customerServlet" method="post">
		<input type="hidden" name="pathUrl" value="<%=pathUrl %>" />
		<input type="hidden" name="op" value="addCustomerDetail" />
		<input type="hidden" name="customerId" value="<%=customer.getId()%>" />
		<table class="tb_info">
			<tr>
				<td width="90px">收货人姓名:</td>
				<td>
					<input class="input_box" name="name" type="text" value="" />
					<span class="tooltip">请填写真实的姓名。</span>
				</td>
			</tr>
			<tr>
				<td>固定电话:</td>
				<td>
					<input class="input_box"  type="text" name="telphone" />
					<span class="tooltip">固定电话与移动电话至少选填一项。</span>
				</td>
			</tr>
			<tr>
				<td>移动电话:</td>
				<td>
					<input class="input_box"  type="text" name="movePhone" />
					<span class="tooltip">固定电话与移动电话至少选填一项。</span>
				</td>
			</tr>
			<tr>
				<td>收货地址:</td>
				<td>
					<input class="input_box_long" type="text" name="address"  />
					<span class="tooltip">请详细填写真实地址。</span>
				</td>
			</tr>
		</table>
		<div style="height:40px;line-height:40px;padding-left:110px;">
			<input type="submit" class="btn61_21" value="提交" />&nbsp;&nbsp;
			<input type="button" class="btn61_21" value="重置" />
		</div>
	</form>
	</div>
	<%@ include file="bottom.jsp"%>
</body>
</html>