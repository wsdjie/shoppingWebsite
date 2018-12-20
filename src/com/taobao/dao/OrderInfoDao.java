package com.taobao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import com.taobao.entity.CartInfo;
import com.taobao.entity.OrderDetailInfo;
import com.taobao.entity.OrderViewInfo;
import com.taobao.util.DBUtil;
import com.taobao.util.IProperty;
import com.taobao.util.Pager;

public class OrderInfoDao {
	/**
	 *��ѯ������
	 */
	public int queryNum(String key){
		// ������ݿ�����
		Connection conn = DBUtil.connectDB();
		// ����sql����ִ�ж��󣬽��������
		PreparedStatement pst = null;
		ResultSet res = null;
		int num=0;
		try {
			pst = conn.prepareStatement(" select COUNT(*) from OrderInfo o inner join CustomerDetailInfo cu on  o.orderId=cu.customerId ");
			res = pst.executeQuery();
			if(res.next()){
				num = res.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("���ݿ�����쳣queryNum....");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return num;
	}
	
	/**
	 * ��ҳ��ѯ������Ϣ
	 * @param pageIndex
	 * @param key
	 * @return pager
	 */
	public Pager<OrderViewInfo> queryOderViewByPager(int pageIndex,String key){
		//ͨ�����ݿ⹤���������ݿ����Ӷ���
		Connection conn = DBUtil.connectDB();
		//����sql���ִ�ж���
		PreparedStatement pst = null;
		ResultSet res = null;
		// �������϶�������Ʒ��Ϣ����
		List<OrderViewInfo> listOrder = new ArrayList<OrderViewInfo>();
		//����Pager������
		Pager<OrderViewInfo> pager = new Pager<OrderViewInfo>();
		pager.setPageSize(IProperty.PAGE_SIZE);
		pager.setPageIndex(pageIndex);
		pager.setTotalRecords(queryNum(key));
		pager.setTotalPages();
		//sql���
		try {
			pst= conn.prepareStatement(" select top "+pager.getPageSize()+" o.orderId,o.status,o.orderTime,c.email,cd.name,cd.telphone,cd.movePhone from OrderInfo o inner join CustomerInfo c on o.customerId = c.id inner join CustomerDetailInfo cd on c.id=cd.customerId where orderId not in(select top "+(pageIndex-1)*pager.getPageSize()+" orderId from OrderInfo o inner join CustomerInfo c on o.customerId = c.id inner join CustomerInfo cu on c.id=cu.id)");
			res = pst.executeQuery();
			if(res.next()){
				OrderViewInfo order = new OrderViewInfo();
				order.setOrderId(res.getInt(1));
				order.setStatus(res.getInt(2));
				order.setOrderTime(res.getString(3)); 
				order.setEmail(res.getString(4));
				order.setName(res.getString(5));
				order.setTelphone(res.getString(6));
				order.setMovePhone(res.getString(7));
				listOrder.add(order);
			}
			pager.setList(listOrder);
		} catch (SQLException e) {
			System.out.println("���ݿ�����쳣queryOderViewByPager....");
		}finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pager;
	}

	/**
	 * ��ѯĳ���ͻ������ж�����¼����
	 * @param 
	 * @return
	 */
	public int Count(int customerId){
		//ͨ�����ݿ⹤���������ݿ����Ӷ���
		Connection conn = DBUtil.connectDB();
		//����sql���ִ�ж���
		PreparedStatement pst = null;
		ResultSet res = null;
		int num=0;			
		//�������������
		try {
			pst = conn.prepareStatement("select COUNT(*) from  OrderInfo o inner join OrderGoodsInfo ord on o.orderId= ord.orderId where o.orderId=?");
			pst.setInt(1, customerId);
			if( res.next()){
				num = res.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return num;
}

	/**
	 * ��ҳ��ѯ������Ϣ
	 * @param pageIndex
	 * @param customerId
	 * @return
	 */
	public Pager<OrderViewInfo> queryOderViewByPager(int pageIndex,int customerId){
		//ͨ�����ݿ⹤���������ݿ����Ӷ���
		Connection conn = DBUtil.connectDB();
		//����sql���ִ�ж���
		PreparedStatement pst = null;
		ResultSet res = null;
		// �������϶�������Ʒ��Ϣ����
		List<OrderViewInfo> listOrder = new ArrayList<OrderViewInfo>();
		//����Pager������
		Pager<OrderViewInfo> pager = new Pager<OrderViewInfo>();
		pager.setPageSize(IProperty.PAGE_SIZE);
		pager.setPageIndex(pageIndex);
		//pager.setTotalRecords(Count(customerId));
		//pager.setTotalPages();
		//sql���
		try {
			pst= conn.prepareStatement(" select top "+pager.getPageSize()+"o.orderId,o.status,o.orderTime,c.email,cd.name,cd.telphone,cd.movePhone from OrderInfo o  inner join CustomerInfo c on o.customerId = c.id inner join CustomerDetailInfo cd on c.id = cd.customerId where o.customerId=? and o.orderId not in( select top "+(pageIndex-1)*pager.getPageSize()+" o.orderId from OrderInfo o  inner join CustomerInfo c on o.customerId = c.id inner join CustomerDetailInfo cd on c.id = cd.customerId where o.customerId=?)");
			pst.setInt(1, customerId);
			pst.setInt(2, customerId);
			res = pst.executeQuery();
			if(res.next()){
				OrderViewInfo order = new OrderViewInfo();
				order.setOrderId(res.getInt(1));
				order.setStatus(res.getInt(2));
				order.setOrderTime(res.getString(3)); 
				order.setEmail(res.getString(4));
				order.setName(res.getString(5));
				order.setTelphone(res.getString(6));
				order.setMovePhone(res.getString(7));
				listOrder.add(order);
			}
			pager.setList(listOrder);
		} catch (SQLException e) {
			System.out.println("��ҳ��ѯ������Ϣ����");
		}finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return pager;
}
	
	/**
	 * ���ݶ�����Ų�ѯ������ϸ��Ϣ
	 * @param orderId
	 * @return
	 */
	public List<OrderDetailInfo> queryOrderDetailByOrderId(int orderId){
		//ͨ�����ݿ⹤���������ݿ����Ӷ���
		Connection conn = DBUtil.connectDB();
		//����sql���ִ�ж���
		PreparedStatement pst = null;
		ResultSet res = null;
		//��������
		
		// �������϶�������Ʒ��Ϣ����
		List<OrderDetailInfo> listOrder = new ArrayList<OrderDetailInfo>();
		//sql���
		try {
			pst= conn.prepareStatement(" select g.goodsId,g.typeId,gt.typeName,g.goodsName,g.price,g.discount,og.quantity,g.photo from OrderGoodsInfo og inner join GoodsInfo g on og.goodsId  = g.goodsId inner join GoodsType gt on g.typeId = gt.typeId where og.orderId = ?");
			pst.setInt(1, orderId);
			res = pst.executeQuery(); 
			if(res.next()){
				OrderDetailInfo od = new OrderDetailInfo();
				od.setGoodsId(res.getInt(1));
				od.setTypeId(res.getString(2));
				od.setTypeName(res.getString(3));
				od.setGoodsName(res.getString(4));
				od.setPrice(res.getFloat(5));
				od.setDiscount(res.getFloat(6));
				od.setQuantity(res.getInt(7));
				od.setPhoto(res.getString(8));
				listOrder.add(od);
			}
		} catch (SQLException e) {
			System.out.println("���ݶ�����Ų�ѯ������ϸ��Ϣ����");
		}finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return listOrder;
	}
	
	public void  queryOrderViewInfoByOrderId(int orderId){
		
	}
	
	/**
	 * ȷ�϶���
	 * @param idSet
	 * @param cart
	 * @param customerId
	 * @return
	 */
	public boolean confirm(Set<Integer> idSet,CartInfo cart,int customerId){
		boolean flag = false;
		//�������ݿ�
		Connection conn = DBUtil.connectDB();
		//�������������
		PreparedStatement pst = null;
		PreparedStatement pst1 = null;
		PreparedStatement pst2 = null;
		int orderId = 0;
		ResultSet res = null;
		long now = System.currentTimeMillis();
		//��дsql���
		String sql = "insert into OrderInfo values(?,DEFAULT,?)";
		String sql1 = "select orderId from OrderInfo where customerId = ? and orderTime = ?";
		String sql2 = "insert into OrderGoodsInfo values(?,?,?)";
		//��ȡ���ڵ�ʱ��
		Date time=new Date(); 
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String str = s.format(time);
		//�������������
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, customerId);
			pst.setString(2, str);
			if(pst.executeUpdate() > 0){
				pst1 = conn.prepareStatement(sql1);
				pst1.setInt(1, customerId);
				pst1.setString(2, str);
				res = pst1.executeQuery();
				if(res.next()){
					orderId = res.getInt(1);
					int i = 0;
					for(Integer goodsId : idSet){
						OrderDetailInfo orderDetail = cart.getCart().get(goodsId);
						pst2 = conn.prepareStatement(sql2);
						pst2.setInt(1, orderId);
						pst2.setInt(2, goodsId);
						pst2.setInt(3, orderDetail.getQuantity());
						if(pst2.executeUpdate() <= 0){
							break;
						}
						i++;
					}
					if(i >= idSet.size()){
						flag = true;
					}
				}
			}
		} catch (SQLException e) {
			System.out.println("�ύ����ʧ�ܣ�");
		} finally {
			DBUtil.closeDB(res, pst, conn);
		}
		return flag;
	}
}
