<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.taobao.dao.GoodsTypeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.taobao.entity.GoodsType"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<base href=\""+basePath+"\">");
%>
<%
	GoodsTypeDao typeDao = new GoodsTypeDao();
	List<GoodsType> typeList = typeDao.queryAllGoodsType();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加商品</title>
<link style="text/csss" rel="stylesheet" href="admin/css/add_skin.css">
<link style="text/csss" rel="stylesheet" href="admin/css/common.css">
<script type="text/javascript">
function chooseFile(fileInput){
	var fileName = fileInput.value;//E:\taobao\WebRoot\product\bao1.jpg
	var index = fileName.lastIndexOf('.');
	
	var suffix = ["jpg","png","gif","bmp"];//支持的图片类型
	var file_suffix = fileName.substring(index+1);//jpg
	for(var s in suffix){
		if(file_suffix == suffix[s]){
			document.getElementById("photo_hidden").value=fileName;
			return;
		}
	}
	alert("请选择图片文件(*.gif,*.png,*.bmp,*.jpg)！");
	document.getElementById("photo_hidden").value="";
}

function submit_form(){
	var photo = document.getElementById("photo_hidden").value;
	if("" == photo){
		alert("请选择商品图片！");
		document.getElementById("photo_file").focus();
		return false;
	}
	return true;
}
</script>
</head>
<body>
<form action="goodsInfoServlet"  method="post" onsubmit="return submit_form();">
	<input type="hidden" value="add" name="op"/>
	<div class="opDiv">
			<div class="titlebar">添加商品</div>
		</div>
	<table class="addTable">
		<tr>
			<td class="name_td">商品名称:</td>
			<td><input type="text" name="goodsName" /></td>
		</tr>
		<tr>
			<td class="name_td">商品分类:</td>
			<td>
				<select name="typeId">
					<%
						if(typeList != null && typeList.size() > 0){
							for(GoodsType type : typeList){
					%>
					<option value="<%=type.getTypeId() %>"><%=type.getTypeName() %></option>
					<%}} %>
				</select>
			</td>
		</tr>
		<tr>
			<td class="name_td">商品价格/折扣:</td>
			<td>
				价格：<input type="text" maxlength="8" size="2" name="price" />&nbsp;
				折扣：<input type="text" maxlength="4" size="2" name="discount" />
			</td>
		</tr>
		<tr>
			<td class="name_td">上架/推荐/新品:</td>
			<td>
				<input class="input_checkbox" type="checkbox" name="status" checked="checked" />上架&nbsp;
				<input class="input_checkbox"  type="checkbox" name="isRecommend" />推荐&nbsp;
				<input class="input_checkbox"  type="checkbox" name="isNew" />新品
			</td>
		</tr>
		<tr>
			<td class="name_td">商品图片:</td>
			<td>
				<input type="hidden" id="photo_hidden" name="photo" />
				<input class="input_file" type="file" id="photo_file" onchange="chooseFile(this);" />
			</td>
		</tr>
		<tr>
			<td class="name_td">商品描述:</td>
			<td>
				<textarea name="remark" rows="5" cols="60"></textarea>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<input class="btn61_21" type="submit" value="提交表单" />&nbsp;&nbsp;
				<input class="btn61_21" type="reset" value="重置表单" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>