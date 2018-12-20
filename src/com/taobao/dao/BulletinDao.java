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
	 * ��ѯ������Ϣ
	 * @param id
	 */
	public Bulletin queryBulletinById(int id){
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sql����ִ�ж��󣬽��������
		PreparedStatement pst = null;
		ResultSet res = null;
		//����Bulletin����
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
			System.out.println("����Id�鹫����Ϣ���� ");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return Bu;

	}
	
	/**
	 * ������
	 * @param key
	 */
	public int Count(String key){
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sql����ִ�ж��󣬽��������
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
			System.out.println("��ѯ����������");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return num;
	}
	/**
	 * ��ҳ��ѯ����
	 */
	public Pager<Bulletin>queryBulletinByPager(int pageIndex, String key){
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sql����ִ�ж��󣬽��������
		PreparedStatement pst = null;
		ResultSet res = null;
		//���� ����
		List<Bulletin> listBu = new ArrayList<Bulletin>();
		//����Pager������
		
		Pager<Bulletin> pager = new Pager<Bulletin>();
		pager.setPageSize(5);
		pager.setPageIndex(pageIndex);
		pager.setTotalRecords(Count(key));
		pager.setTotalPages();
		try {
			pst = conn.prepareStatement("select top "+pager.getPageSize()+"* from Bulletin where userId=1 and id not in(select TOP "+(pageIndex-1)*pager.getPageSize()+" id from Bulletin where userId=1) ");
			res = pst.executeQuery();
			while(res.next()){
				//��������
				Bulletin Bu = new Bulletin();
				//��װ
				Bu.setId(res.getInt(1));
				Bu.setTitle(res.getString(2));
				Bu.setContent(res.getString(3));
				Bu.setUserId(res.getInt(4));
				Bu.setCreateTime(res.getString(5));
				listBu.add(Bu);
			}
			pager.setList(listBu);
		} catch (SQLException e) {
			System.out.println("��ҳ��ѯ�������");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pager;
	}
}
