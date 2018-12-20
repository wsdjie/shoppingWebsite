<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	request.setCharacterEncoding("utf-8");
	int goodsId = request.getParameter("goodsId") == null ? 1 : Integer.parseInt(request.getParameter("goodsId"));
	GoodsInfoDao gDao = new GoodsInfoDao();
	GoodsInfo g = gDao.queryGoodsInfoByGoodsId(goodsId);
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
		function addCart(){
			var strContent = document.getElementById("quantity").value;
			if(isNaN(strContent)){
				alert("购买数量不能为必须是大于0的整数！");
			}else{
				var count = parseInt(strContent);
				if(count <= 0){
					alert("购买数量不能为必须是大于0的整数！");
				}else{
					document.cartForm.submit();
				}
			}
		}
		function changeNum(flag){
			var strContent = document.getElementById("quantity").value;
			if(isNaN(strContent)){
				document.getElementById("quantity").value = 1;
				alert("购买数量必须是大于0的整数！");
			}else{
				var count = parseInt(strContent);
				if(flag == 1){
					document.getElementById("quantity").value = count + 1;
				}else{
					if(count <= 1){
						document.getElementById("quantity").value = 1;
						alert("购买数量必须是大于0的整数！");
					}else{
						document.getElementById("quantity").value = count - 1;
					}
				}
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
					<td width="620" height="50" align="left" class="main_2_fonts">
						详细分类路径
					</td>
					<td width="620" height="50" align="right"></td>
				</tr>
			</table>
		</div>
		<br />
		<br />
		<table width="1240" border="0" cellspacing="0" cellpadding="0"
			align="center" class="table_center ">
			<tr>
				<td width="400" height="400">
					<img src="product/<%=g.getPhoto() %>" width="400" height="400"/>
				</td>
				<td valign="top">
					<form action="cartServlet" method="post" name="cartForm">
					<input type="hidden" name="op" value="addCart"/>
					<input type="hidden" name="goodsId" value="<%=g.getGoodsId()%>"/>
					<input type="hidden" name="goodsName" value="<%=g.getGoodsName()%>"/>
					<input type="hidden" name="typeId" value="<%=g.getTypeId()%>"/>
					<input type="hidden" name="typeName" value="<%=g.getTypeName()%>"/>
					<input type="hidden" name="discount" value="<%=g.getDiscount()%>"/>
					<input type="hidden" name="price" value="<%=g.getPrice()%>"/>
					<input type="hidden" name="photo" value="<%=g.getPhoto()%>"/>
					<table width="800" border="0" cellspacing="0" cellpadding="0"
						align="center">
						<tr>
							<td height="100" colspan="2" align="center"
								class="art_show_fonts1">
								<a href="goods.jsp?typeId=<%=g.getTypeId() %>" style="font-family: 黑体; font-size: 20px;"><%=g.getTypeName() %></a>：<%=g.getGoodsName() %>
							</td>
						</tr>
						<tr>
							<td width="101" height="50" align="center" valign="middle"
								bgcolor="#E8E8E8" class="main_2_fonts">
								商品价格
							</td>
							<td width="699" bgcolor="#E8E8E8" class="cart_fonts1">
								<%=StringUtil.formatDouble(g.getPrice()*g.getDiscount()/10) %>元
							</td>
						</tr>
						<tr>
							<td height="50" align="center" valign="middle"
								class="main_2_fonts">
								商品类型
							</td>
							<td height="50" class="main_2_fonts">
								<a href="goods.jsp?typeId=<%=g.getTypeId() %>" style="font-family: 黑体; font-size: 20px;"><%=g.getTypeName() %></a>
							</td>
						</tr>
						<tr>
							<td height="50" align="center" valign="middle"
								class="main_2_fonts">
								商品描述
							</td>
							<td height="50">
								<%=g.getRemark() %>
							</td>
						</tr>
						<tr>
							<td height="50" align="center" valign="middle"
								class="main_2_fonts">
								商品数量
							</td>
							<td height="50">
								<input name="" type="button" value="-" class="main_2_input" onclick="changeNum(0);"/>
								<input name="quantity" type="text" value="1" class="main_2_txt" id="quantity"/>
								<input name="" type="button" value="+" class="main_2_input" onclick="changeNum(1);"/>
							</td>
						</tr>
						<tr>
							<td height="100" align="center">
								&nbsp;
							</td>
							<td height="100" align="center">
								<input name="button" type="button" class="details_input"
									value="立即购买" />
								&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="button" type="button" class="details_input"
									value="加入购物车" onclick="addCart();"/>
							</td>
						</tr>
					</table>
					</form>
				</td>
			</tr>
		</table>
		<%@ include file="bottom.jsp"%>
	</body>
</html>
