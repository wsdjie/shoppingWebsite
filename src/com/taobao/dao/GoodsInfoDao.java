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
			System.out.println("���ݿ�����쳣queryGoodsForIndex....");
		} finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(res, pst, conn);
		}
		return listInfo;
	}
	/**
	 * ��������ID��ѯǰ������Ʒ��Ϣ
	 * @param typeId
	 */
	public List<GoodsInfo> queryTop3GoodsInfo(int typeId){
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();

		// ����sql����ִ�ж��󣬽��������
		PreparedStatement pst = null;
		ResultSet res = null;

		// �������϶�������Ʒ��Ϣ����
		List<GoodsInfo> listGI = new ArrayList<GoodsInfo>();

		try {
			//��ѯǰ������Ʒ��Ϣ����������
			pst = conn.prepareStatement(" SELECT TOP 3 * FROM GoodsInfo WHERE typeId = ? ORDER BY goodsId ASC ");

			pst.setInt(1,typeId);
			
			res = pst.executeQuery();

			while (res.next()) {
				GoodsInfo gi = new GoodsInfo();

				gi.setGoodsId(res.getInt(1));// goodsid
				gi.setTypeId(res.getInt(2));// ����ID
				gi.setGoodsName(res.getString(3));// ��Ʒ����
				gi.setPrice(res.getFloat(4));// ��Ʒ����
				gi.setDiscount(res.getFloat(5));// �ۿ���
				gi.setIsNew(res.getInt(6));// �Ƿ���Ʒ0��/1��
				gi.setIsRecommend(res.getInt(7));// �Ƿ��Ƽ�0��/��
				gi.setStatus(res.getInt(8));// ��ǰ�Ƿ��ϼ�0��/1��
				gi.setPhoto(res.getString(9));// ��ƷͼƬ
				gi.setRemark(res.getString(10));// ��Ʒ����

				listGI.add(gi);
			}
		} catch (SQLException e) {
			System.out.println("��ѯǰ������Ʒ��Ϣ�����ݿ�����쳣");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return listGI;
	}
	
	/**
	 * ������ƷID��ѯ��Ʒ��Ϣ
	 * @param goodsId
	 */
	public GoodsInfo queryGoodsInfoByGoodsId(int goodsId){
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sql����ִ�ж��󣬽��������
		PreparedStatement pst = null;
		ResultSet res = null;
				
		GoodsInfo gi=new GoodsInfo();
		try {
			pst = conn.prepareStatement("select * from  GoodsInfo g inner join GoodsType gt on g.typeId=gt.typeId where g.goodsId=?");
			pst.setInt(1,goodsId );
			res = pst.executeQuery();
			if(res.next()){
				gi.setGoodsId(res.getInt(1));// goodsid
				gi.setTypeId(res.getInt(2));// ����ID
				gi.setGoodsName(res.getString(3));// ��Ʒ����
				gi.setPrice(res.getFloat(4));// ��Ʒ����
				gi.setDiscount(res.getFloat(5));// �ۿ���
				gi.setIsNew(res.getInt(6));// �Ƿ���Ʒ0��/1��
				gi.setIsRecommend(res.getInt(7));// �Ƿ��Ƽ�0��/��
				gi.setStatus(res.getInt(8));// ��ǰ�Ƿ��ϼ�0��/1��
				gi.setPhoto(res.getString(9));// ��ƷͼƬ
				gi.setRemark(res.getString(10));
				gi.setTypeName(res.getString(11));//��������
			}
		} catch (SQLException e) {
			System.out.println("������ƷID��ѯ��Ʒ��Ϣ�����ݿ�����쳣");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return gi;
	}

	/**
	 *��ѯ��Ʒ��������
	 */
	 public int ZongYeShu(int typeId){
		// ������ݿ�����
			Connection conn = DBUtil.connectDB();
			// ����sql����ִ�ж��󣬽��������
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
				System.out.println("��ѯ��ҳ�������ݿ�����쳣");
			} finally {
				DBUtil.closeDB(res, pst, conn);
			}
			return num;
	 }
	 
	/**
	 * ��ҳ��ѯ
	 * @param pageIndex
	 * @param typeId
	 */
	public Pager<GoodsInfo> queryGoodsInfoByPager(int pageIndex,int typeId){
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sql����ִ�ж��󣬽��������
		PreparedStatement pst = null;
		ResultSet res = null;
		// �������϶�������Ʒ��Ϣ����
		List<GoodsInfo> listGI = new ArrayList<GoodsInfo>();
		//����Pager������
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
				//����goodsInfo����
				GoodsInfo gi = new GoodsInfo();
				//��ֵ
				gi.setGoodsId(res.getInt(1));// goodsid
				gi.setTypeId(res.getInt(2));// ����ID
				gi.setGoodsName(res.getString(3));// ��Ʒ����
				gi.setPrice(res.getFloat(4));// ��Ʒ����
				gi.setDiscount(res.getFloat(5));// �ۿ���
				gi.setIsNew(res.getInt(6));// �Ƿ���Ʒ0��/1��
				gi.setIsRecommend(res.getInt(7));// �Ƿ��Ƽ�0��/��
				gi.setStatus(res.getInt(8));// ��ǰ�Ƿ��ϼ�0��/1��
				gi.setPhoto(res.getString(9));// ��ƷͼƬ
				gi.setRemark(res.getString(10));// ��Ʒ����
				listGI.add(gi);
			}
			pager.setList(listGI);
		} catch (SQLException e) {
			System.out.println("��Ʒ���࣬���ݿ�����쳣");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pager;
	}
	
	public List<GoodsInfo> Fuzzyquery(String name){
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sql����ִ�ж��󣬽��������
		PreparedStatement pst = null;
		ResultSet res = null;
		List<GoodsInfo> pi=new ArrayList<GoodsInfo>();
		try {
			pst = conn.prepareStatement("select * from  GoodsInfo where goodsName like ? ");
			pst.setString(1, "%"+name+"%");
			
			res = pst.executeQuery();
			while(res.next()){
				//����goodsInfo����
				GoodsInfo ww = new GoodsInfo();
				//��ֵ
				ww.setGoodsId(res.getInt(1));// goodsid
				ww.setTypeId(res.getInt(2));// ����ID
				ww.setGoodsName(res.getString(3));// ��Ʒ����
				ww.setPrice(res.getFloat(4));// ��Ʒ����
				ww.setDiscount(res.getFloat(5));// �ۿ���
				ww.setIsNew(res.getInt(6));// �Ƿ���Ʒ0��/1��
				ww.setIsRecommend(res.getInt(7));// �Ƿ��Ƽ�0��/��
				ww.setStatus(res.getInt(8));// ��ǰ�Ƿ��ϼ�0��/1��
				ww.setPhoto(res.getString(9));// ��ƷͼƬ
				ww.setRemark(res.getString(10));// ��Ʒ����
				pi.add(ww);
			}
		} catch (SQLException e) {
			System.out.println("������Ʒ���Ʋ�ѯ��Ʒ��Ϣ�����ݿ�����쳣");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pi;
	}

}
