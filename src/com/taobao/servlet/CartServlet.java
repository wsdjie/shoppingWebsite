package com.taobao.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.taobao.entity.CartInfo;
import com.taobao.entity.OrderDetailInfo;

public class CartServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//���ý����ַ���
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		//����ҳ�洫������ֵ
		String op = request.getParameter("op");
		//����session�������
		HttpSession session = request.getSession();
		
		if(op.equals("")){
			response.sendRedirect("index.jsp");
			/**
			 * ����Ʒ��ӵ����ﳵ
			 */
		}else if(op.equals("addCart")){
			//����ҳ�洫������ֵ
			int goodsId = Integer.parseInt(request.getParameter("goodsId"));
			String goodsName = request.getParameter("goodsName");
			String typeId =request.getParameter("typeId");
			String typeName = request.getParameter("typeName");
			float discount = Float.parseFloat(request.getParameter("discount"));
			float price = Float.parseFloat(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			String photo = request.getParameter("photo");
			//������Ʒ��Ϣʵ�������
			OrderDetailInfo odi= new OrderDetailInfo();
			//����ʵ�������
			CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
			//����ҳ���ϵ����ݴ�ŵ�ʵ����Ϣ������
			odi.setGoodsId(goodsId);
			odi.setGoodsName(goodsName);
			odi.setTypeId(typeId);
			odi.setTypeName(typeName);
			odi.setDiscount(discount);
			odi.setPrice(price);
			odi.setQuantity(quantity);
			odi.setPhoto(photo);
			ct.addGoodsToCart(odi);
			session.setAttribute("cart", ct);
			response.sendRedirect("cart.jsp");
			/**
			 * ����Idɾ����Ʒ
			 */
			}else if(op.equals("delete")){
				//����ʵ�������
				CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
				//��ȡҳ�洫������ֵ
				int goodsId = Integer.parseInt(request.getParameter("goodsId"));
				ct.deleteGoods(goodsId);
				session.setAttribute("cart", ct);
				response.sendRedirect("cart.jsp");
				/**
				 * ��չ��ﳵ
				 */
			}else if(op.equals("clear")){
				//����ʵ�������
				CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
				session.removeAttribute("cart");
				response.sendRedirect("cart.jsp");
				/**
				 * �޸�����
				 */
			}else if(op.equals("changeQuantity")){
				//����ʵ�������
				CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
				//��ȡҳ�洫������ֵ
				int goodsId = Integer.parseInt(request.getParameter("goodsId"));
				int flag = Integer.parseInt(request.getParameter("flag"));
				ct.changeQuantity(flag, goodsId);
				session.setAttribute("cart", ct);
				response.sendRedirect("cart.jsp");
			}
	}
}
