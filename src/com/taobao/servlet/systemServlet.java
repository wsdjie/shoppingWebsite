package com.taobao.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.taobao.dao.UserInfoDao;
import com.taobao.entity.UserInfo;

public class systemServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);

	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 设置接收与响应字符集
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		// 接受op值判断执行操作
		String op = request.getParameter("op");
		//获取管理员信息实体类
		UserInfo us=new UserInfo();
		//获取管理员工具类对象
		UserInfoDao usdao=new UserInfoDao();
		// 设置Session存放内容
		HttpSession session = request.getSession();
		if(op.equals("login"))
		{
			// 接收管理員输入的用户名和密码
			String userName=request.getParameter("userName");
			String userPwd=request.getParameter("userPwd");
			us.setUserName(userName);
			us.setUserPwd(userPwd);
			boolean flag=usdao.login(userName, userPwd);
			if(flag==true)
			{
				// 获取当前系统时间
				Date dt = new Date();
				// 设置时间日期格式
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				// 将时间类型转换为字符类型
				String a = sdf.format(dt);
				session.setAttribute("loginTime",a);
				session.setAttribute("loginUser", usdao.queryUseName(userName));
				response.sendRedirect("admin/index.jsp");
			}
			else{
				request.setAttribute("msg", "用户名或密码错误！");
				request.getRequestDispatcher("admin/login.jsp").forward(request,
						response);
			}
		}
	}
}
