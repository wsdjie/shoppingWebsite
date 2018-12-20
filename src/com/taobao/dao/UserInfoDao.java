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
			System.out.println("���ݿ�����쳣login....");
		}
		finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(res, pst, conn);
		}
		// ����flag
		return flag;
	}
	
	public UserInfo queryUseName(String userName)
	{
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sqlִ�ж���
		PreparedStatement pst = null;
		// ������������󣬱�������ݿ��в�ѯ����������
		ResultSet res = null;
		//��������Աʵ������󣬴�Ų�ѯ���Ĺ���Ա��Ϣ
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
			System.out.println("���ݿ�����쳣queryUseName....");
		}finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(res, pst, conn);
		}
		return us;
	}
}
