package com.taobao.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.taobao.dao.CutomerInfoDao;
import com.taobao.dao.GoodsInfoDao;
import com.taobao.entity.CustomerInfo;
import com.taobao.entity.GoodsInfo;

public class queryServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
         
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		String name = new String(request.getParameter("textfield").getBytes("ISO8859-1"),"utf-8");
		//获取模糊查询的值
		// 获取商品信息实体类
		GoodsInfo cxsp=new GoodsInfo();
		GoodsInfoDao D1=new GoodsInfoDao();
 	    List<GoodsInfo> pi=D1.Fuzzyquery(name);
	    request.setAttribute("pi", pi);
		request.getRequestDispatcher("mhcx.jsp").forward(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
  
		    doGet(request,response);
	}

}
