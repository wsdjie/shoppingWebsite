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
	 * 用户登录
	 * 
	 * @param 登录邮箱
	 *            （email）
	 * @param 登录密码
	 *            （pwd）
	 * @return
	 */
	public boolean taologin(String email, String pwd) {
		// 调用数据库连接方法
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
			System.out.println("数据库操作异常login....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(res, pst, conn);
		}
		// 返回flag
		return flag;
	}

	/**
	 * 用户注册
	 * 
	 * @param 用户信息表ct
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
			// 获取当前系统时间
			Date dt = new Date();
			// 设置时间日期格式
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// 将时间类型转换为字符类型
			String a = sdf.format(dt);

			ct.setRegisterTime(a);

			pst.setString(3, ct.getRegisterTime());
			int num = pst.executeUpdate();
			if (num > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			System.out.println("数据库操作异常register....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(null, pst, conn);
		}
		return flag;
	}

	/**
	 * 根据用户名查询用户信息
	 * 
	 * @param email
	 * @return
	 */
	public CustomerInfo queryEmail(String email) {
		// 获得数据库连接
		Connection conn = DBUtil.connectDB();
		// 声明sql执行对象
		PreparedStatement pst = null;
		// 声明结果集对象，保存从数据库中查询出来的内容
		ResultSet res = null;
		// 声明对象
		CustomerInfo cus = new CustomerInfo();
		try {
			// 初始化sql执行对象
			pst = conn
					.prepareStatement(" select * from CustomerInfo where email=? ");
			pst.setString(1, email);
			// 执行查询操作，并得到结果集
			res = pst.executeQuery();
			if (res.next()) {
				cus.setId(res.getInt(1));
				cus.setEmail(res.getString(2));
				cus.setPwd(res.getString(3));
				cus.setRegisterTime(res.getString(4));
			}
		} catch (SQLException e) {
			System.out.println("数据库操作异常queryEmail....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(res, pst, conn);
		}
		return cus;
	}

	/**
	 * 根据用户编号查询用户详细信息
	 * 
	 * @param customerId
	 * @return
	 */
	public CustomerDetailInfo queryCustomerDetailInfoByCustomerId(int customerId) {
		// 通过数据库工具类获得数据库链接对象
		Connection conn = DBUtil.connectDB();
		// 声明sql语句执行对象
		PreparedStatement pst = null;
		ResultSet res = null;
		// 定义对象;
		CustomerDetailInfo customer = null;
		// sql语句
		try {
			pst = conn
					.prepareStatement(" select * from CustomerDetailInfo where customerId = ? ");
			pst.setInt(1, customerId);
			res = pst.executeQuery();
			// 遍历res集合中的值
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
					.println("数据库操作异常queryCustomerDetailInfoByCustomerId....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(null, pst, conn);
		}
		return customer;
	}

	/**
	 * 根据客户编号查询客户信息
	 * 
	 * @param Id
	 * @return
	 */
	public CustomerInfo queryCustomerById(int Id) {
		// 通过数据库工具类获得数据库链接对象
		Connection conn = DBUtil.connectDB();
		// 声明sql语句执行对象
		PreparedStatement pst = null;
		ResultSet res = null;
		// 定义对象;
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
			System.out.println("数据库操作异常queryCustomerById....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(null, pst, conn);
		}
		return cuInfo;
	}

	/**
	 * 添加客户详细信息
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
			System.out.println("数据库操作异常addCustomerDetail....");
		} finally {
			// 关闭链接释放资源
			DBUtil.closeDB(null, pst, conn);
		}
		return flag;
	}
}
