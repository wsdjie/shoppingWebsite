package com.taobao.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
	/**
	 * 连接数据库
	 * @return
	 */
	public static Connection connectDB(){
		try {
			//加载驱动程序
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			//获得连接并返回
			return DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=qlzx", "sa", "123456");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 关闭数据库资源
	 * @param rs
	 * @param smt
	 * @param con
	 */
	public static void closeDB(ResultSet res,PreparedStatement pst,Connection conn)
	{
		try {
			if(res != null)
			{
				res.close();
			}
			if(pst != null)
			{
				pst.close();
			}
			if(conn != null)
			{
				conn.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
