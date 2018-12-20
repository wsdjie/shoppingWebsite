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

		// ���ý�������Ӧ�ַ���
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		// ����session
		HttpSession session = request.getSession();
		// ����opֵ�ж�ִ�в���
		String op = request.getParameter("op");
		// ����dao���������
		OrderInfoDao od = new OrderInfoDao();
		// ȷ�϶���
		if (op.equals("confirm")) {
			// ��ȡҳ�洫������ֵ
			Set<Integer> idSet = (Set<Integer>) session.getAttribute("confirm");
			CartInfo cartInfo = (CartInfo) session.getAttribute("cart");
			CustomerInfo customer = (CustomerInfo) session.getAttribute("customer");

			boolean bl = od.confirm(idSet, cartInfo, customer.getId());

			if (bl) {
				CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
				session.removeAttribute("cart");
			
				request.setAttribute("msg", "ȷ�϶����ɹ���");
				request.getRequestDispatcher("ok.jsp").forward(request,
						response);
			} else {
				request.setAttribute("msg", "ȷ�϶���ʧ�ܣ�");
				request.getRequestDispatcher("failed.jsp").forward(request,
						response);
			}
		}
	}

}
