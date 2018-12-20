package com.taobao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.taobao.entity.GoodsInfo;
import com.taobao.util.DBUtil;
import com.taobao.util.Pager;

public class GoodsInfoDao {
	public List<GoodsInfo> queryGoodsForIndex(int a) {
		Connection conn = DBUtil.connectDB();
		PreparedStatement pst = null;
		ResultSet res = null;
		List<GoodsInfo> listInfo = new ArrayList<GoodsInfo>();
		String sql = "";
		if (a == 1) {
			sql = " select top 4 * from GoodsInfo where status =0 and isRecommend=0 ";
		} else if (a == 2) {
			sql = " select top 4 * from GoodsInfo where status =0 and isNew=0 ";
		} else if (a == 3) {
			sql = " select * from GoodsInfo where goodsId in(select top 4 goodsId from OrderGoodsInfo group by goodsId order by COUNT(goodsId) desc) and status=0  ";
		} else if (a == 4) {
			sql = " select * from GoodsInfo where goodsId in(select top 3 goodsId from OrderGoodsInfo group by goodsId order by COUNT(goodsId) desc) and status=0  and status =0 and isNew=0 ";
		}
		try {
			pst = conn.prepareStatement(sql);
			res = pst.executeQuery();
			while (res.next()) {
				GoodsInfo gs = new GoodsInfo();
				gs.setGoodsId(res.getInt(1));
				gs.setTypeId(res.getInt(2));
				gs.setGoodsName(res.getString(3));
				gs.setPrice(res.getFloat(4));
				gs.setDiscount(res.getFloat(5));
				gs.setIsNew(res.getInt(6));
				gs.setIsRecommend(res.getInt(7));
				gs.setStatus(res.getInt(8));
				gs.setPhoto(res.getString(9));
				gs.setRemark(res.getString(10));
				listInfo.add(gs);
			}

		} catch (SQLException e) {
			System.out.println("数据库操作异常queryGoodsForIndex....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(res, pst, conn);
		}
		return listInfo;
	}
	/**
	 * 根据类型ID查询前三个商品信息
	 * @param typeId
	 */
	public List<GoodsInfo> queryTop3GoodsInfo(int typeId){
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();

		// 声明sql传输执行对象，结果集对象
		PreparedStatement pst = null;
		ResultSet res = null;

		// 声明集合对象存放商品信息对象
		List<GoodsInfo> listGI = new ArrayList<GoodsInfo>();

		try {
			//查询前三个商品信息，并且排序
			pst = conn.prepareStatement(" SELECT TOP 3 * FROM GoodsInfo WHERE typeId = ? ORDER BY goodsId ASC ");

			pst.setInt(1,typeId);
			
			res = pst.executeQuery();

			while (res.next()) {
				GoodsInfo gi = new GoodsInfo();

				gi.setGoodsId(res.getInt(1));// goodsid
				gi.setTypeId(res.getInt(2));// 类型ID
				gi.setGoodsName(res.getString(3));// 商品名称
				gi.setPrice(res.getFloat(4));// 商品单价
				gi.setDiscount(res.getFloat(5));// 折扣率
				gi.setIsNew(res.getInt(6));// 是否新品0新/1旧
				gi.setIsRecommend(res.getInt(7));// 是否推荐0是/否
				gi.setStatus(res.getInt(8));// 当前是否上架0上/1下
				gi.setPhoto(res.getString(9));// 商品图片
				gi.setRemark(res.getString(10));// 商品描述

				listGI.add(gi);
			}
		} catch (SQLException e) {
			System.out.println("查询前三个商品信息，数据库操作异常");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return listGI;
	}
	
	/**
	 * 根据商品ID查询商品信息
	 * @param goodsId
	 */
	public GoodsInfo queryGoodsInfoByGoodsId(int goodsId){
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql传输执行对象，结果集对象
		PreparedStatement pst = null;
		ResultSet res = null;
				
		GoodsInfo gi=new GoodsInfo();
		try {
			pst = conn.prepareStatement("select * from  GoodsInfo g inner join GoodsType gt on g.typeId=gt.typeId where g.goodsId=?");
			pst.setInt(1,goodsId );
			res = pst.executeQuery();
			if(res.next()){
				gi.setGoodsId(res.getInt(1));// goodsid
				gi.setTypeId(res.getInt(2));// 类型ID
				gi.setGoodsName(res.getString(3));// 商品名称
				gi.setPrice(res.getFloat(4));// 商品单价
				gi.setDiscount(res.getFloat(5));// 折扣率
				gi.setIsNew(res.getInt(6));// 是否新品0新/1旧
				gi.setIsRecommend(res.getInt(7));// 是否推荐0是/否
				gi.setStatus(res.getInt(8));// 当前是否上架0上/1下
				gi.setPhoto(res.getString(9));// 商品图片
				gi.setRemark(res.getString(10));
				gi.setTypeName(res.getString(11));//类型名称
			}
		} catch (SQLException e) {
			System.out.println("根据商品ID查询商品信息，数据库操作异常");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return gi;
	}

	/**
	 *查询商品的总条数
	 */
	 public int ZongYeShu(int typeId){
		// 获得数据库连接
			Connection conn = DBUtil.connectDB();
			// 声明sql传输执行对象，结果集对象
			PreparedStatement pst = null;
			ResultSet res = null;
			int num=0;
			try {
				pst = conn.prepareStatement("select COUNT(*) from GoodsInfo where typeId=?");
				pst.setInt(1, typeId);
				res = pst.executeQuery();
				if(res.next()){
				 num = res.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("查询总页数，数据库操作异常");
			} finally {
				DBUtil.closeDB(res, pst, conn);
			}
			return num;
	 }
	 
	/**
	 * 分页查询
	 * @param pageIndex
	 * @param typeId
	 */
	public Pager<GoodsInfo> queryGoodsInfoByPager(int pageIndex,int typeId){
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql传输执行对象，结果集对象
		PreparedStatement pst = null;
		ResultSet res = null;
		// 声明集合对象存放商品信息对象
		List<GoodsInfo> listGI = new ArrayList<GoodsInfo>();
		//调用Pager工具类
		Pager<GoodsInfo> pager = new Pager<GoodsInfo>();
		pager.setPageSize(8);
		pager.setPageIndex(pageIndex);
		pager.setTotalRecords(ZongYeShu(typeId));
		pager.setTotalPages();
		try {
			pst=conn.prepareStatement("  select top "+pager.getPageSize()+"* from GoodsInfo where typeId=? and goodsId not in (select top "+(pageIndex-1)*pager.getPageSize()+" goodsId from GoodsInfo where typeId=?)");
			pst.setInt(1,typeId);
			pst.setInt(2,typeId);
			res = pst.executeQuery();
			while(res.next()){
				//创建goodsInfo对象
				GoodsInfo gi = new GoodsInfo();
				//存值
				gi.setGoodsId(res.getInt(1));// goodsid
				gi.setTypeId(res.getInt(2));// 类型ID
				gi.setGoodsName(res.getString(3));// 商品名称
				gi.setPrice(res.getFloat(4));// 商品单价
				gi.setDiscount(res.getFloat(5));// 折扣率
				gi.setIsNew(res.getInt(6));// 是否新品0新/1旧
				gi.setIsRecommend(res.getInt(7));// 是否推荐0是/否
				gi.setStatus(res.getInt(8));// 当前是否上架0上/1下
				gi.setPhoto(res.getString(9));// 商品图片
				gi.setRemark(res.getString(10));// 商品描述
				listGI.add(gi);
			}
			pager.setList(listGI);
		} catch (SQLException e) {
			System.out.println("商品分类，数据库操作异常");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pager;
	}
	
	public List<GoodsInfo> Fuzzyquery(String name){
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql传输执行对象，结果集对象
		PreparedStatement pst = null;
		ResultSet res = null;
		List<GoodsInfo> pi=new ArrayList<GoodsInfo>();
		try {
			pst = conn.prepareStatement("select * from  GoodsInfo where goodsName like ? ");
			pst.setString(1, "%"+name+"%");
			
			res = pst.executeQuery();
			while(res.next()){
				//创建goodsInfo对象
				GoodsInfo ww = new GoodsInfo();
				//存值
				ww.setGoodsId(res.getInt(1));// goodsid
				ww.setTypeId(res.getInt(2));// 类型ID
				ww.setGoodsName(res.getString(3));// 商品名称
				ww.setPrice(res.getFloat(4));// 商品单价
				ww.setDiscount(res.getFloat(5));// 折扣率
				ww.setIsNew(res.getInt(6));// 是否新品0新/1旧
				ww.setIsRecommend(res.getInt(7));// 是否推荐0是/否
				ww.setStatus(res.getInt(8));// 当前是否上架0上/1下
				ww.setPhoto(res.getString(9));// 商品图片
				ww.setRemark(res.getString(10));// 商品描述
				pi.add(ww);
			}
		} catch (SQLException e) {
			System.out.println("根据商品名称查询商品信息，数据库操作异常");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pi;
	}

}
