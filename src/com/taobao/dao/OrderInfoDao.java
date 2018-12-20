package com.taobao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import com.taobao.entity.CartInfo;
import com.taobao.entity.OrderDetailInfo;
import com.taobao.entity.OrderViewInfo;
import com.taobao.util.DBUtil;
import com.taobao.util.IProperty;
import com.taobao.util.Pager;

public class OrderInfoDao {
	/**
	 *查询总条数
	 */
	public int queryNum(String key){
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql传输执行对象，结果集对象
		PreparedStatement pst = null;
		ResultSet res = null;
		int num=0;
		try {
			pst = conn.prepareStatement(" select COUNT(*) from OrderInfo o inner join CustomerDetailInfo cu on  o.orderId=cu.customerId ");
			res = pst.executeQuery();
			if(res.next()){
				num = res.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("数据库操作异常queryNum....");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return num;
	}
	
	/**
	 * 分页查询订单信息
	 * @param pageIndex
	 * @param key
	 * @return pager
	 */
	public Pager<OrderViewInfo> queryOderViewByPager(int pageIndex,String key){
		//通过数据库工具类获得数据库链接对象
		Connection conn = DBUtil.connectDB();
		//声明sql语句执行对象
		PreparedStatement pst = null;
		ResultSet res = null;
		// 声明集合对象存放商品信息对象
		List<OrderViewInfo> listOrder = new ArrayList<OrderViewInfo>();
		//调用Pager工具类
		Pager<OrderViewInfo> pager = new Pager<OrderViewInfo>();
		pager.setPageSize(IProperty.PAGE_SIZE);
		pager.setPageIndex(pageIndex);
		pager.setTotalRecords(queryNum(key));
		pager.setTotalPages();
		//sql语句
		try {
			pst= conn.prepareStatement(" select top "+pager.getPageSize()+" o.orderId,o.status,o.orderTime,c.email,cd.name,cd.telphone,cd.movePhone from OrderInfo o inner join CustomerInfo c on o.customerId = c.id inner join CustomerDetailInfo cd on c.id=cd.customerId where orderId not in(select top "+(pageIndex-1)*pager.getPageSize()+" orderId from OrderInfo o inner join CustomerInfo c on o.customerId = c.id inner join CustomerInfo cu on c.id=cu.id)");
			res = pst.executeQuery();
			if(res.next()){
				OrderViewInfo order = new OrderViewInfo();
				order.setOrderId(res.getInt(1));
				order.setStatus(res.getInt(2));
				order.setOrderTime(res.getString(3)); 
				order.setEmail(res.getString(4));
				order.setName(res.getString(5));
				order.setTelphone(res.getString(6));
				order.setMovePhone(res.getString(7));
				listOrder.add(order);
			}
			pager.setList(listOrder);
		} catch (SQLException e) {
			System.out.println("数据库操作异常queryOderViewByPager....");
		}finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pager;
	}

	/**
	 * 查询某个客户的所有订单记录条数
	 * @param 
	 * @return
	 */
	public int Count(int customerId){
		//通过数据库工具类获得数据库链接对象
		Connection conn = DBUtil.connectDB();
		//声明sql语句执行对象
		PreparedStatement pst = null;
		ResultSet res = null;
		int num=0;			
		//创建命令管理器
		try {
			pst = conn.prepareStatement("select COUNT(*) from  OrderInfo o inner join OrderGoodsInfo ord on o.orderId= ord.orderId where o.orderId=?");
			pst.setInt(1, customerId);
			if( res.next()){
				num = res.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return num;
}

	/**
	 * 分页查询订单信息
	 * @param pageIndex
	 * @param customerId
	 * @return
	 */
	public Pager<OrderViewInfo> queryOderViewByPager(int pageIndex,int customerId){
		//通过数据库工具类获得数据库链接对象
		Connection conn = DBUtil.connectDB();
		//声明sql语句执行对象
		PreparedStatement pst = null;
		ResultSet res = null;
		// 声明集合对象存放商品信息对象
		List<OrderViewInfo> listOrder = new ArrayList<OrderViewInfo>();
		//调用Pager工具类
		Pager<OrderViewInfo> pager = new Pager<OrderViewInfo>();
		pager.setPageSize(IProperty.PAGE_SIZE);
		pager.setPageIndex(pageIndex);
		//pager.setTotalRecords(Count(customerId));
		//pager.setTotalPages();
		//sql语句
		try {
			pst= conn.prepareStatement(" select top "+pager.getPageSize()+"o.orderId,o.status,o.orderTime,c.email,cd.name,cd.telphone,cd.movePhone from OrderInfo o  inner join CustomerInfo c on o.customerId = c.id inner join CustomerDetailInfo cd on c.id = cd.customerId where o.customerId=? and o.orderId not in( select top "+(pageIndex-1)*pager.getPageSize()+" o.orderId from OrderInfo o  inner join CustomerInfo c on o.customerId = c.id inner join CustomerDetailInfo cd on c.id = cd.customerId where o.customerId=?)");
			pst.setInt(1, customerId);
			pst.setInt(2, customerId);
			res = pst.executeQuery();
			if(res.next()){
				OrderViewInfo order = new OrderViewInfo();
				order.setOrderId(res.getInt(1));
				order.setStatus(res.getInt(2));
				order.setOrderTime(res.getString(3)); 
				order.setEmail(res.getString(4));
				order.setName(res.getString(5));
				order.setTelphone(res.getString(6));
				order.setMovePhone(res.getString(7));
				listOrder.add(order);
			}
			pager.setList(listOrder);
		} catch (SQLException e) {
			System.out.println("分页查询订单信息错误");
		}finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pager;
}
	
	/**
	 * 根据订单编号查询订单详细信息
	 * @param orderId
	 * @return
	 */
	public List<OrderDetailInfo> queryOrderDetailByOrderId(int orderId){
		//通过数据库工具类获得数据库链接对象
		Connection conn = DBUtil.connectDB();
		//声明sql语句执行对象
		PreparedStatement pst = null;
		ResultSet res = null;
		//声明对象
		
		// 声明集合对象存放商品信息对象
		List<OrderDetailInfo> listOrder = new ArrayList<OrderDetailInfo>();
		//sql语句
		try {
			pst= conn.prepareStatement(" select g.goodsId,g.typeId,gt.typeName,g.goodsName,g.price,g.discount,og.quantity,g.photo from OrderGoodsInfo og inner join GoodsInfo g on og.goodsId  = g.goodsId inner join GoodsType gt on g.typeId = gt.typeId where og.orderId = ?");
			pst.setInt(1, orderId);
			res = pst.executeQuery(); 
			if(res.next()){
				OrderDetailInfo od = new OrderDetailInfo();
				od.setGoodsId(res.getInt(1));
				od.setTypeId(res.getString(2));
				od.setTypeName(res.getString(3));
				od.setGoodsName(res.getString(4));
				od.setPrice(res.getFloat(5));
				od.setDiscount(res.getFloat(6));
				od.setQuantity(res.getInt(7));
				od.setPhoto(res.getString(8));
				listOrder.add(od);
			}
		} catch (SQLException e) {
			System.out.println("根据订单编号查询订单详细信息错误！");
		}finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return listOrder;
	}
	
	public void  queryOrderViewInfoByOrderId(int orderId){
		
	}
	
	/**
	 * 确认订单
	 * @param idSet
	 * @param cart
	 * @param customerId
	 * @return
	 */
	public boolean confirm(Set<Integer> idSet,CartInfo cart,int customerId){
		boolean flag = false;
		//连接数据库
		Connection conn = DBUtil.connectDB();
		//声明命令管理器
		PreparedStatement pst = null;
		PreparedStatement pst1 = null;
		PreparedStatement pst2 = null;
		int orderId = 0;
		ResultSet res = null;
		long now = System.currentTimeMillis();
		//编写sql语句
		String sql = "insert into OrderInfo values(?,DEFAULT,?)";
		String sql1 = "select orderId from OrderInfo where customerId = ? and orderTime = ?";
		String sql2 = "insert into OrderGoodsInfo values(?,?,?)";
		//获取现在的时间
		Date time=new Date(); 
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String str = s.format(time);
		//创建命令管理器
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, customerId);
			pst.setString(2, str);
			if(pst.executeUpdate() > 0){
				pst1 = conn.prepareStatement(sql1);
				pst1.setInt(1, customerId);
				pst1.setString(2, str);
				res = pst1.executeQuery();
				if(res.next()){
					orderId = res.getInt(1);
					int i = 0;
					for(Integer goodsId : idSet){
						OrderDetailInfo orderDetail = cart.getCart().get(goodsId);
						pst2 = conn.prepareStatement(sql2);
						pst2.setInt(1, orderId);
						pst2.setInt(2, goodsId);
						pst2.setInt(3, orderDetail.getQuantity());
						if(pst2.executeUpdate() <= 0){
							break;
						}
						i++;
					}
					if(i >= idSet.size()){
						flag = true;
					}
				}
			}
		} catch (SQLException e) {
			System.out.println("提交订单失败！");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return flag;
	}
}
