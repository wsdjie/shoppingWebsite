package com.taobao.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.taobao.dao.OrderInfoDao;
import com.taobao.entity.CartInfo;
import com.taobao.entity.CustomerInfo;

import sun.jdbc.odbc.OdbcDef;

public class OrderServlet extends HttpServlet {
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
		// 设置session
		HttpSession session = request.getSession();
		// 接收op值判断执行操作
		String op = request.getParameter("op");
		// 创建dao工具类对象
		OrderInfoDao od = new OrderInfoDao();
		// 确认订单
		if (op.equals("confirm")) {
			// 获取页面传过来的值
			Set<Integer> idSet = (Set<Integer>) session.getAttribute("confirm");
			CartInfo cartInfo = (CartInfo) session.getAttribute("cart");
			CustomerInfo customer = (CustomerInfo) session.getAttribute("customer");

			boolean bl = od.confirm(idSet, cartInfo, customer.getId());

			if (bl) {
				CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
				session.removeAttribute("cart");
			
				request.setAttribute("msg", "确认订单成功！");
				request.getRequestDispatcher("ok.jsp").forward(request,
						response);
			} else {
				request.setAttribute("msg", "确认订单失败！");
				request.getRequestDispatcher("failed.jsp").forward(request,
						response);
			}
		}
	}

}
