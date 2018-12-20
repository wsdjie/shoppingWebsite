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
		// ���ý�������Ӧ�ַ���
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		// ������ҳ���ӡ���ݹ���
		PrintWriter out = response.getWriter();
		// ����Session�������
		HttpSession session = request.getSession();
		// ����opֵ�ж�ִ�в���
		String op = request.getParameter("op");
		// ��ȡCutomerInfoDao������
		CutomerInfoDao cmi = new CutomerInfoDao();
		// ��ȡ�û���Ϣʵ����
		CustomerInfo ct = new CustomerInfo();
		/**
		 * �û���¼
		 */
		// opΪloginʱִ�е�¼����
		if (op.equals("login")) {
			// �����û�������û���������
			String email = request.getParameter("email");
			String pwd = request.getParameter("pwd");
			// �ж��û�������û����������Ƿ�Ϊ��
			if (email.equals("") || pwd.equals("")) {
				// Ϊ��ʱ��ʾ�û�����Ϸ��û���������
				request.setAttribute("msg", "������Ϸ��û��������룡");
				request.getRequestDispatcher("login.jsp").forward(request,
						response);

				// ��Ϊ��ʱ������һ������
			} else {

				// ���û�������û�����������뵽�û���Ϣʵ������
				ct.setEmail(email);
				ct.setPwd(pwd);
				// ����dao���еķ���ֵ�����Ҵ��ݲ���
				boolean flag = cmi.taologin(email, pwd);
				// ������ֵΪtrueʱ����ת����վ��ҳ
				if (flag == true) {
					// ���û���Ϣ����session��
					session.setAttribute("customer", cmi.queryEmail(email));
					response.sendRedirect("index.jsp");
					// ������ֵΪfalseʱ����ʾ�û��û������������
				} else {
					request.setAttribute("msg", "�û������������");
					request.getRequestDispatcher("login.jsp").forward(request,
							response);
				}
			}

		}

		/**
		 * �û�ע��
		 */
		// opΪregistʱִ��ע�����
		else if (op.equals("regist")) {
			// �����û�������û���������
			String remail = request.getParameter("remail");
			String rpwd = request.getParameter("rpwd");
			String repwd = request.getParameter("repwd");
			// �ж��û����������ظ������Ƿ�Ϊ��
			if (remail.equals("") || repwd.equals("") || rpwd.equals("")) {
				// Ϊ��ʱ
				request.setAttribute("msg", "������Ϸ��û��������룡");
				request.getRequestDispatcher("register.jsp").forward(request,
						response);
				// ��Ϊ���������һ������
			} else {
				// �ж��������ظ������Ƿ�һ��
				if (rpwd.equals(repwd)) {
					// һ��ʱ����ȡ�û��������룬�����û���Ϣʵ������
					ct.setEmail(remail);
					ct.setPwd(repwd);
					// ����dao���еķ���ֵ���������û���Ϣʵ����
					boolean flag = cmi.register(ct);
					// ������ֵΪtrueʱ����ʾ�û�ע��ɹ�������ת����¼ҳ��
					if (flag == true) {
						out.print("�����ɹ���3�����ת����¼ҳ��......");
						response.setHeader("refresh", "3;URL=login.jsp");
						// ������ֵΪfalseʱ����ʾ�û��˻��ѱ�ע���������������
					} else {
						request.setAttribute("msg", "�˻��ѱ�ע���������������");
						request.getRequestDispatcher("register.jsp").forward(
								request, response);
					}
				}
				// �����벻һ��ʱ����ʾ�û����벻һ��
				else {
					request.setAttribute("msg", "����������벻һ�£���˶����룡");
					request.getRequestDispatcher("register.jsp").forward(
							request, response);
				}
			}
		}
		/**
		 * ����û���ϸ��Ϣ
		 */
		else if (op.equals("addCustomerDetail")) {
			// �����û���ϸ��Ϣʵ�������
			CustomerDetailInfo cmdate = new CustomerDetailInfo();
			// �����û���������
			int customerId;
			String ci = request.getParameter("customerId");
			String pathUrl = request.getParameter("pathUrl");
			String name = request.getParameter("name");
			String telphone = request.getParameter("telphone");
			String movePhone = request.getParameter("movePhone");
			String address = request.getParameter("address");
			// ����Ϣ��ŵ�ʵ���������
			if(name.equals("")||telphone.equals("")||movePhone.equals("")||address.equals(""))
			{
				request.setAttribute("msg", "��������д������Ϣ��");
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
				// ����dao���еĲ�ѯ�û���Ϣ����
				boolean flag = cmi.addCustomerDetail(cmdate);
				// �жϲ����Ƿ�ɹ�
				if (flag == true) {
					// Ϊtrueʱ��ת��������Ϣҳ��
					request.getRequestDispatcher("confirm.jsp").forward(request,
							response);
				} else {
					request.setAttribute("msg", "����û���ϸ��Ϣʧ�ܣ�");
					// ��ת
					request.getRequestDispatcher("failed.jsp").forward(request,
							response);
				}
			}
		}
	}
}
