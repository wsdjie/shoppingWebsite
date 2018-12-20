package com.taobao.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.jms.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.taobao.dao.CutomerInfoDao;
import com.taobao.dao.GoodsTypeDao;
import com.taobao.entity.CustomerDetailInfo;
import com.taobao.entity.CustomerInfo;
import com.taobao.entity.GoodsType;

public class customerServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 设置接收与响应字符集
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		// 设置向页面打印内容工具
		PrintWriter out = response.getWriter();
		// 设置Session存放内容
		HttpSession session = request.getSession();
		// 接受op值判断执行操作
		String op = request.getParameter("op");
		// 获取CutomerInfoDao工具类
		CutomerInfoDao cmi = new CutomerInfoDao();
		// 获取用户信息实体类
		CustomerInfo ct = new CustomerInfo();
		/**
		 * 用户登录
		 */
		// op为login时执行登录操作
		if (op.equals("login")) {
			// 接收用户输入的用户名和密码
			String email = request.getParameter("email");
			String pwd = request.getParameter("pwd");
			// 判断用户输入的用户名与密码是否为空
			if (email.equals("") || pwd.equals("")) {
				// 为空时提示用户输入合法用户名或密码
				request.setAttribute("msg", "请输入合法用户名或密码！");
				request.getRequestDispatcher("login.jsp").forward(request,
						response);

				// 不为空时进入下一步操作
			} else {

				// 将用户输入的用户名与密码存入到用户信息实体类中
				ct.setEmail(email);
				ct.setPwd(pwd);
				// 接收dao类中的返回值，并且传递参数
				boolean flag = cmi.taologin(email, pwd);
				// 当返回值为true时，跳转到网站主页
				if (flag == true) {
					// 将用户信息存入session中
					session.setAttribute("customer", cmi.queryEmail(email));
					response.sendRedirect("index.jsp");
					// 当返回值为false时，提示用户用户名或密码错误
				} else {
					request.setAttribute("msg", "用户名或密码错误！");
					request.getRequestDispatcher("login.jsp").forward(request,
							response);
				}
			}

		}

		/**
		 * 用户注册
		 */
		// op为regist时执行注册操作
		else if (op.equals("regist")) {
			// 接收用户输入的用户名和密码
			String remail = request.getParameter("remail");
			String rpwd = request.getParameter("rpwd");
			String repwd = request.getParameter("repwd");
			// 判断用户名、密码重复密码是否为空
			if (remail.equals("") || repwd.equals("") || rpwd.equals("")) {
				// 为空时
				request.setAttribute("msg", "请输入合法用户名或密码！");
				request.getRequestDispatcher("register.jsp").forward(request,
						response);
				// 不为空则进入下一步操作
			} else {
				// 判断密码与重复密码是否一致
				if (rpwd.equals(repwd)) {
					// 一致时，获取用户名和密码，存入用户信息实体类中
					ct.setEmail(remail);
					ct.setPwd(repwd);
					// 接收dao类中的返回值，并传递用户信息实体类
					boolean flag = cmi.register(ct);
					// 当返回值为true时，提示用户注册成功，并跳转到登录页面
					if (flag == true) {
						out.print("操作成功！3秒后跳转到登录页面......");
						response.setHeader("refresh", "3;URL=login.jsp");
						// 当返回值为false时，提示用户账户已被注册或输入内容有误，
					} else {
						request.setAttribute("msg", "账户已被注册或输入内容有误！");
						request.getRequestDispatcher("register.jsp").forward(
								request, response);
					}
				}
				// 当密码不一致时，提示用户密码不一致
				else {
					request.setAttribute("msg", "您输入的密码不一致，请核对密码！");
					request.getRequestDispatcher("register.jsp").forward(
							request, response);
				}
			}
		}
		/**
		 * 添加用户详细信息
		 */
		else if (op.equals("addCustomerDetail")) {
			// 创建用户详细信息实体类对象
			CustomerDetailInfo cmdate = new CustomerDetailInfo();
			// 接收用户输入内容
			int customerId;
			String ci = request.getParameter("customerId");
			String pathUrl = request.getParameter("pathUrl");
			String name = request.getParameter("name");
			String telphone = request.getParameter("telphone");
			String movePhone = request.getParameter("movePhone");
			String address = request.getParameter("address");
			// 将信息存放到实体类对象中
			if(name.equals("")||telphone.equals("")||movePhone.equals("")||address.equals(""))
			{
				request.setAttribute("msg", "请认真填写配送信息！");
				request.getRequestDispatcher("cuowu.jsp").forward(request,
						response);
			}else
			{
				customerId = Integer.parseInt(ci);
				cmdate.setCustomerId(customerId);
				cmdate.setName(name);
				cmdate.setTelphone(telphone);
				cmdate.setMovePhone(movePhone);
				cmdate.setAddress(address);
				// 调用dao类中的查询用户信息方法
				boolean flag = cmi.addCustomerDetail(cmdate);
				// 判断操作是否成功
				if (flag == true) {
					// 为true时跳转到订单信息页面
					request.getRequestDispatcher("confirm.jsp").forward(request,
							response);
				} else {
					request.setAttribute("msg", "添加用户详细信息失败！");
					// 跳转
					request.getRequestDispatcher("failed.jsp").forward(request,
							response);
				}
			}
		}
	}
}
