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
		// ���ý�������Ӧ�ַ���
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		// ����opֵ�ж�ִ�в���
		String op = request.getParameter("op");
		//��ȡ����Ա��Ϣʵ����
		UserInfo us=new UserInfo();
		//��ȡ����Ա���������
		UserInfoDao usdao=new UserInfoDao();
		// ����Session�������
		HttpSession session = request.getSession();
		if(op.equals("login"))
		{
			// ���չ���T������û���������
			String userName=request.getParameter("userName");
			String userPwd=request.getParameter("userPwd");
			us.setUserName(userName);
			us.setUserPwd(userPwd);
			boolean flag=usdao.login(userName, userPwd);
			if(flag==true)
			{
				// ��ȡ��ǰϵͳʱ��
				Date dt = new Date();
				// ����ʱ�����ڸ�ʽ
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				// ��ʱ������ת��Ϊ�ַ�����
				String a = sdf.format(dt);
				session.setAttribute("loginTime",a);
				session.setAttribute("loginUser", usdao.queryUseName(userName));
				response.sendRedirect("admin/index.jsp");
			}
			else{
				request.setAttribute("msg", "�û������������");
				request.getRequestDispatcher("admin/login.jsp").forward(request,
						response);
			}
		}
	}
}
