package com.taobao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.taobao.entity.UserInfo;
import com.taobao.util.DBUtil;

public class UserInfoDao {
	public boolean login(String userName ,String userPwd)
	{
		Connection conn = DBUtil.connectDB();
		PreparedStatement pst = null;
		ResultSet res = null;
		boolean flag = false;
		try {
			pst=conn.prepareStatement(" select COUNT (*) from UserInfo where userName=? and userPwd=? ");
			pst.setString(1, userName);
			pst.setString(2, userPwd);
			res=pst.executeQuery();
			int num = 0;
			if (res.next()) {
				num = res.getInt(1);
			}

			if (num > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			System.out.println("数据库操作异常login....");
		}
		finally {
			// 关闭链接释放资源
			DBUtil.closeDB(res, pst, conn);
		}
		// 返回flag
		return flag;
	}
	
	public UserInfo queryUseName(String userName)
	{
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql执行对象
		PreparedStatement pst = null;
		// 声明结果集对象，保存从数据库中查询出来的内容
		ResultSet res = null;
		//声明管理员实体类对象，存放查询出的管理员信息
		UserInfo us=new UserInfo();
		try {
			pst=conn.prepareStatement(" select * from UserInfo where userName=? ");
			pst.setString(1, userName);
			res=pst.executeQuery();
			if(res.next())
			{
				us.setId(res.getInt(1));
				us.setUserName(res.getString(2));
				us.setUserPwd(res.getString(3));
			}
		} catch (SQLException e) {
			System.out.println("数据库操作异常queryUseName....");
		}finally {
			// 关闭链接释放资源
			DBUtil.closeDB(res, pst, conn);
		}
		return us;
	}
}
