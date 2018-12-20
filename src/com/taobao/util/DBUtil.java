package com.taobao.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
	/**
	 * �������ݿ�
	 * @return
	 */
	public static Connection connectDB(){
		try {
			//������������
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			//������Ӳ�����
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
	 * �ر����ݿ���Դ
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
