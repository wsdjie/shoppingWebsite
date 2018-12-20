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
	 * 添加商品加入购物车
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
	 * 修改数量
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
	 * 删除指定的商品
	 * @param goodsId
	 */
	public void deleteGoods(int goodsId){
		cart.remove(goodsId);
	}
	/**
	 * 总计价格
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