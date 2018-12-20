package com.taobao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.taobao.entity.Bulletin;
import com.taobao.util.DBUtil;
import com.taobao.util.Pager;

public class BulletinDao {
	/**
	 * 查询公告信息
	 * @param id
	 */
	public Bulletin queryBulletinById(int id){
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql传输执行对象，结果集对象
		PreparedStatement pst = null;
		ResultSet res = null;
		//创建Bulletin对象
		Bulletin Bu = new Bulletin();
		try {
			pst = conn.prepareStatement("   select * from Bulletin b inner join UserInfo u on b.userId =u.id where b.id = ?");
			pst.setInt(1,id);
			res = pst.executeQuery();
			if(res.next()){
				Bu.setId(res.getInt(1));
				Bu.setTitle(res.getString(2));
				Bu.setContent(res.getString(3));
				Bu.setUserId(res.getInt(4));
				Bu.setCreateTime(res.getString(5));
				Bu.setUserName(res.getString(6));
			}
		} catch (SQLException e) {
			System.out.println("根据Id查公告信息错误 ");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return Bu;

	}
	
	/**
	 * 总条数
	 * @param key
	 */
	public int Count(String key){
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql传输执行对象，结果集对象
		PreparedStatement pst = null;
		ResultSet res = null;
		int num=0;
		try {
			pst = conn.prepareStatement("select COUNT(*) from Bulletin ");
			res = pst.executeQuery();
			if(res.next()){
				num = res.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("查询总条数有误！");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return num;
	}
	/**
	 * 分页查询公告
	 */
	public Pager<Bulletin>queryBulletinByPager(int pageIndex, String key){
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql传输执行对象，结果集对象
		PreparedStatement pst = null;
		ResultSet res = null;
		//声明 集合
		List<Bulletin> listBu = new ArrayList<Bulletin>();
		//调用Pager工具类
		
		Pager<Bulletin> pager = new Pager<Bulletin>();
		pager.setPageSize(5);
		pager.setPageIndex(pageIndex);
		pager.setTotalRecords(Count(key));
		pager.setTotalPages();
		try {
			pst = conn.prepareStatement("select top "+pager.getPageSize()+"* from Bulletin where userId=1 and id not in(select TOP "+(pageIndex-1)*pager.getPageSize()+" id from Bulletin where userId=1) ");
			res = pst.executeQuery();
			while(res.next()){
				//创建对象
				Bulletin Bu = new Bulletin();
				//封装
				Bu.setId(res.getInt(1));
				Bu.setTitle(res.getString(2));
				Bu.setContent(res.getString(3));
				Bu.setUserId(res.getInt(4));
				Bu.setCreateTime(res.getString(5));
				listBu.add(Bu);
			}
			pager.setList(listBu);
		} catch (SQLException e) {
			System.out.println("分页查询公告错误！");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pager;
	}
}
