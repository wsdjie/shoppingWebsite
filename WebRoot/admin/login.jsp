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
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>千里之行-管理员登录</title>
		<style type="text/css">
		body{width:100%;height:100%;margin:0px;}
		#div_all{position:absolute;width:582px;height:386px;left:50%;top:50%;margin:-193px 0px 0px -291px;background:url(admin/images/login_div_bg.gif) no-repeat 0px 0px;}
		#div_login{position:relative;left:220px;top:170px;width:300px;height:70px;}
		table{width:100%;height:100%;color:#505050;}
		td{height:30px;}
		.input_box{width:120px;height:18px;border:1px solid #505050;}
		.btn_login{width:52px;height:46px;background:url(admin/images/login.gif) no-repeat 0px 0px;border:0px;padding:0px;margin:0px;cursor:pointer;}
		</style>
		<script type="text/javascript">
		//验证登录
		function checkLogin(){
			var userName_input = document.loginForm.userName;
			if(userName_input.value==""){
				alert("请输入用户名！");
				userName_input.focus();
				return false;
			}
			var userPwd_input = document.loginForm.userPwd;
			if(userPwd_input.value==""){
				alert("请输入密码！");
				userPwd_input.focus();
				return false;
			}
		}

		function loadPage(){
			document.loginForm.userName.focus();
		}
		</script>
	</head>
	<body onload="loadPage();">
		<div id="div_all">
			<div id="div_login">
			<form name="loginForm" action="systemServlet" method="post" onsubmit="return checkLogin();">
			<input type="hidden" name="op" value="login" />
			<table align="center">
				<tr>
					<td align="right">
						用户名:
					</td>
					<td>
						<input class="input_box" tabindex="1" type="text" name="userName">
					</td>
					<td rowspan="2">
						<input type="submit" class="btn_login" value="" title="登录系统" />
					</td>
				</tr>
				<tr>
					<td align="right">
						密码:
					</td>
					<td>
						<input class="input_box" tabindex="2" type="password" name="userPwd">
					</td>
				</tr>
				<%
					if(request.getAttribute("msg") != null){
				%>
				<tr><td colspan="2" align="center"><font size="-1" color="red"><%=request.getAttribute("msg") %></font></td></tr>
				<%} %>
			</table> 
		</form>
			</div>
		</div>
		<!-- 
		<form action="servlet/SystemManage" method="post">
			<input type="hidden" name="op" value="login" />
			
			<table align="center" border="1" width="300px">
				<tr>
					<td align="right">
						用户名
					</td>
					<td>
						<input type="text" name="userName">
					</td>
				</tr>
				<tr>
					<td align="right">
						用户密码
						<br>
					</td>
					<td>
						<input type="password" name="userPwd">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="登录" />&nbsp;&nbsp;
					</td>
				</tr>
			</table> 
		</form>-->
	</body>
</html>