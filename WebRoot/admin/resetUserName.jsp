<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<base href=\""+basePath+"\">");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<link style="text/csss" rel="stylesheet" href="admin/css/add_skin.css">
<link style="text/csss" rel="stylesheet" href="admin/css/common.css">
<style type="text/css">
.btn_td{text-indent:50px;}
</style>
<script type="text/javascript">
function submit_form(){
	//用户名称
	var userName = document.myForm.userName;
	if(""==userName.value){
		alert("请填写用户名！");
		userName.focus();
		return false;
	}
	return true;
}
</script>
</head>
<body>
<form name="myForm" action="systemServlet" method="post" onsubmit="return submit_form();">
	<input type="hidden" name="op" value="resetUserName" />
	<div class="opDiv">
		<div class="titlebar">修改用户名</div>
	</div>
	<table class="addTable">
		<tr>
			<td class="name_td" width="100px">用户名称：</td>
			<td><input type="text" name="userName" /></td>
		</tr>
		<tr>
			<td colspan="2" align="left" class="btn_td">
				<input class="btn61_21" type="submit" value="确认" />&nbsp;&nbsp;
				<input class="btn61_21" type="reset" value="重置" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>