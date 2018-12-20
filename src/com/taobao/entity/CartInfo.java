package com.taobao.entity;

import java.util.HashMap;
import java.util.Map;

public class CartInfo {
	private Map<Integer,OrderDetailInfo> cart = new HashMap<Integer,OrderDetailInfo>();

	public Map<Integer, OrderDetailInfo> getCart() {
		return cart;
	}
	
	public void setCart(Map<Integer, OrderDetailInfo> cart) {
		this.cart = cart;
	}

	public CartInfo(Map<Integer, OrderDetailInfo> cart) {
		this.cart = cart;
	}

	public CartInfo() {
	}
	/**
	 * �����Ʒ���빺�ﳵ
	 * @param orderDetail
	 */
	public void addGoodsToCart(OrderDetailInfo orderDetail){
		if(cart.containsKey(orderDetail.getGoodsId())){
			OrderDetailInfo detail = cart.get(orderDetail.getGoodsId());
			detail.setQuantity(detail.getQuantity() + orderDetail.getQuantity());
			cart.put(detail.getGoodsId(), detail);
		}else{
			cart.put(orderDetail.getGoodsId(), orderDetail);
		}
	}
	/**
	 * �޸�����
	 * @param flag
	 * @param goodsId
	 */
	public void changeQuantity(int flag,int goodsId){
		OrderDetailInfo detail = cart.get(goodsId);
		if(flag == 0){
			detail.setQuantity(detail.getQuantity() - 1);
		}else{
			detail.setQuantity(detail.getQuantity() + 1);
		}
		cart.put(goodsId, detail);
	}
	/**
	 * ɾ��ָ������Ʒ
	 * @param goodsId
	 */
	public void deleteGoods(int goodsId){
		cart.remove(goodsId);
	}
	/**
	 * �ܼƼ۸�
	 * @return
	 */
	public double totalPrice(){
		double totalPrice = 0;
		for(int key : cart.keySet()){
			totalPrice += cart.get(key).subTotalPrice();
		}
		return totalPrice;
	}
}