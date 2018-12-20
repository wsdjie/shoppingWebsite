package com.taobao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.taobao.entity.CustomerDetailInfo;
import com.taobao.entity.CustomerInfo;
import com.taobao.util.DBUtil;

public class CutomerInfoDao {

	/**
	 * �û���¼
	 * 
	 * @param ��¼����
	 *            ��email��
	 * @param ��¼����
	 *            ��pwd��
	 * @return
	 */
	public boolean taologin(String email, String pwd) {
		// �������ݿ����ӷ���
		Connection conn = DBUtil.connectDB();
		PreparedStatement pst = null;
		ResultSet res = null;
		boolean flag = false;
		try {
			pst = conn
					.prepareStatement(" select COUNT (*) from CustomerInfo where email=? and pwd=? ");
			pst.setString(1, email);
			pst.setString(2, pwd);
			res = pst.executeQuery();
			int num = 0;
			if (res.next()) {
				num = res.getInt(1);
			}

			if (num > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			System.out.println("���ݿ�����쳣login....");
		} finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(res, pst, conn);
		}
		// ����flag
		return flag;
	}

	/**
	 * �û�ע��
	 * 
	 * @param �û���Ϣ��ct
	 * @return
	 */
	public boolean register(CustomerInfo ct) {
		Connection conn = DBUtil.connectDB();
		PreparedStatement pst = null;
		boolean flag = false;
		try {
			pst = conn
					.prepareStatement(" insert into CustomerInfo values (?,?,?) ");
			pst.setString(1, ct.getEmail());
			pst.setString(2, ct.getPwd());
			// ��ȡ��ǰϵͳʱ��
			Date dt = new Date();
			// ����ʱ�����ڸ�ʽ
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// ��ʱ������ת��Ϊ�ַ�����
			String a = sdf.format(dt);

			ct.setRegisterTime(a);

			pst.setString(3, ct.getRegisterTime());
			int num = pst.executeUpdate();
			if (num > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			System.out.println("���ݿ�����쳣register....");
		} finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(null, pst, conn);
		}
		return flag;
	}

	/**
	 * �����û�����ѯ�û���Ϣ
	 * 
	 * @param email
	 * @return
	 */
	public CustomerInfo queryEmail(String email) {
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sqlִ�ж���
		PreparedStatement pst = null;
		// ������������󣬱�������ݿ��в�ѯ����������
		ResultSet res = null;
		// ��������
		CustomerInfo cus = new CustomerInfo();
		try {
			// ��ʼ��sqlִ�ж���
			pst = conn
					.prepareStatement(" select * from CustomerInfo where email=? ");
			pst.setString(1, email);
			// ִ�в�ѯ���������õ������
			res = pst.executeQuery();
			if (res.next()) {
				cus.setId(res.getInt(1));
				cus.setEmail(res.getString(2));
				cus.setPwd(res.getString(3));
				cus.setRegisterTime(res.getString(4));
			}
		} catch (SQLException e) {
			System.out.println("���ݿ�����쳣queryEmail....");
		} finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(res, pst, conn);
		}
		return cus;
	}

	/**
	 * �����û���Ų�ѯ�û���ϸ��Ϣ
	 * 
	 * @param customerId
	 * @return
	 */
	public CustomerDetailInfo queryCustomerDetailInfoByCustomerId(int customerId) {
		// ͨ�����ݿ⹤���������ݿ����Ӷ���
		Connection conn = DBUtil.connectDB();
		// ����sql���ִ�ж���
		PreparedStatement pst = null;
		ResultSet res = null;
		// �������;
		CustomerDetailInfo customer = null;
		// sql���
		try {
			pst = conn
					.prepareStatement(" select * from CustomerDetailInfo where customerId = ? ");
			pst.setInt(1, customerId);
			res = pst.executeQuery();
			// ����res�����е�ֵ
			if (res.next()) {
				customer = new CustomerDetailInfo();
				customer.setCustomerId(res.getInt(1));
				customer.setName(res.getString(2));
				customer.setTelphone(res.getString(3));
				customer.setMovePhone(res.getString(4));
				customer.setAddress(res.getString(5));
			}
		} catch (SQLException e) {
			System.out
					.println("���ݿ�����쳣queryCustomerDetailInfoByCustomerId....");
		} finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(null, pst, conn);
		}
		return customer;
	}

	/**
	 * ���ݿͻ���Ų�ѯ�ͻ���Ϣ
	 * 
	 * @param Id
	 * @return
	 */
	public CustomerInfo queryCustomerById(int Id) {
		// ͨ�����ݿ⹤���������ݿ����Ӷ���
		Connection conn = DBUtil.connectDB();
		// ����sql���ִ�ж���
		PreparedStatement pst = null;
		ResultSet res = null;
		// �������;
		CustomerInfo cuInfo = new CustomerInfo();
		try {
			pst = conn
					.prepareStatement(" select * from CustomerInfo c inner join CustomerDetailInfo cd on c.id = cd.customerId where c.id = ?");
			pst.setInt(1, Id);
			res = pst.executeQuery();
			if (res.next()) {
				cuInfo.setId(res.getInt(1));
				cuInfo.setEmail(res.getString(2));
				cuInfo.setPwd(res.getString(3));
				cuInfo.setRegisterTime(res.getString(4));
				cuInfo.setCustomerId(res.getInt(5));
				cuInfo.setName(res.getString(6));
				cuInfo.setTelphone(res.getString(7));
				cuInfo.setMovePhone(res.getString(8));
				cuInfo.setAddress(res.getString(9));
			}

		} catch (SQLException e) {
			System.out.println("���ݿ�����쳣queryCustomerById....");
		} finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(null, pst, conn);
		}
		return cuInfo;
	}

	/**
	 * ��ӿͻ���ϸ��Ϣ
	 * 
	 * @param customer
	 * @return
	 */
	public boolean addCustomerDetail(CustomerDetailInfo customerDetail) {
		Connection conn = DBUtil.connectDB();
		PreparedStatement pst = null;
		boolean flag = false;
		try {
			pst = conn
					.prepareStatement(" insert into CustomerDetailInfo values(?,?,?,?,?) ");
			pst.setInt(1, customerDetail.getCustomerId());
			pst.setString(2, customerDetail.getName());
			pst.setString(3, customerDetail.getTelphone());
			pst.setString(4, customerDetail.getMovePhone());
			pst.setString(5, customerDetail.getAddress());
			int num = pst.executeUpdate();
			if (num > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			System.out.println("���ݿ�����쳣addCustomerDetail....");
		} finally {
			// �ر������ͷ���Դ
			DBUtil.closeDB(null, pst, conn);
		}
		return flag;
	}
}
