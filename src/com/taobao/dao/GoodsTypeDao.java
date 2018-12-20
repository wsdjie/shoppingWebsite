package com.taobao.dao;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.taobao.entity.GoodsType;
import com.taobao.util.DBUtil;

/**
 * 执行queryNavigateGoodsType()方法
 * @author Administrator
 *
 */
public class GoodsTypeDao {
	public List<GoodsType> queryNavigateGoodsType() {
		Connection conn = DBUtil.connectDB();
		PreparedStatement pst = null;
		ResultSet res = null;
		List<GoodsType> listType = new ArrayList<GoodsType>();
		try {
			pst = conn.prepareStatement(" SELECT TOP 7 * FROM GoodsType ");
			res = pst.executeQuery();
			while (res.next()) {
				GoodsType gs = new GoodsType();
				gs.setTypeId(res.getInt(1));
				gs.setTypeName(res.getString(2));
				listType.add(gs);
			}
		} catch (SQLException e) {
			System.out.println("数据库操作异常queryNavigateGoodsType....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(res, pst, conn);
		}
		return listType;
	}

	/**
	 * 执行queryAllGoodsType()方法
	 * @return
	 */
	public List<GoodsType> queryAllGoodsType() {
		Connection conn = DBUtil.connectDB();
		PreparedStatement pst = null;
		ResultSet res = null;
		List<GoodsType> listType = new ArrayList<GoodsType>();
		try {
			pst = conn.prepareStatement(" SELECT * FROM GoodsType ");
			res = pst.executeQuery();
			while (res.next()) {
				GoodsType gs = new GoodsType();
				gs.setTypeId(res.getInt(1));
				gs.setTypeName(res.getString(2));
				listType.add(gs);
			}
		} catch (SQLException e) {
			System.out.println("数据库操作异常queryAllGoodsType....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(res, pst, conn);
		}
		return listType;
	}
	
	
}
