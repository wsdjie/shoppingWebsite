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
		//设置接收字符集
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		//接收页面传过来的值
		String op = request.getParameter("op");
		//声明session存放内容
		HttpSession session = request.getSession();
		
		if(op.equals("")){
			response.sendRedirect("index.jsp");
			/**
			 * 将商品添加到购物车
			 */
		}else if(op.equals("addCart")){
			//接收页面传过来的值
			int goodsId = Integer.parseInt(request.getParameter("goodsId"));
			String goodsName = request.getParameter("goodsName");
			String typeId =request.getParameter("typeId");
			String typeName = request.getParameter("typeName");
			float discount = Float.parseFloat(request.getParameter("discount"));
			float price = Float.parseFloat(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			String photo = request.getParameter("photo");
			//创建商品信息实体类对象
			OrderDetailInfo odi= new OrderDetailInfo();
			//创建实体类对象
			CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
			//接收页面上的内容存放到实体信息对象中
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
			 * 根据Id删除商品
			 */
			}else if(op.equals("delete")){
				//创建实体类对象
				CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
				//获取页面传过来的值
				int goodsId = Integer.parseInt(request.getParameter("goodsId"));
				ct.deleteGoods(goodsId);
				session.setAttribute("cart", ct);
				response.sendRedirect("cart.jsp");
				/**
				 * 清空购物车
				 */
			}else if(op.equals("clear")){
				//创建实体类对象
				CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
				session.removeAttribute("cart");
				response.sendRedirect("cart.jsp");
				/**
				 * 修改数量
				 */
			}else if(op.equals("changeQuantity")){
				//创建实体类对象
				CartInfo ct =  session.getAttribute("cart")==null ? new CartInfo():(CartInfo)session.getAttribute("cart");
				//获取页面传过来的值
				int goodsId = Integer.parseInt(request.getParameter("goodsId"));
				int flag = Integer.parseInt(request.getParameter("flag"));
				ct.changeQuantity(flag, goodsId);
				session.setAttribute("cart", ct);
				response.sendRedirect("cart.jsp");
			}
	}
}
