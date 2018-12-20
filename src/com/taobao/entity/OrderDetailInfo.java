package com.taobao.entity;

import java.text.DecimalFormat;

public class OrderDetailInfo {
	private int goodsId;
	private String typeId;
	private String typeName;
	private String goodsName;
	private float price;
	private float discount;
	private int quantity;
	private String photo;
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public float getDiscount() {
		return discount;
	}
	public void setDiscount(float discount) {
		this.discount = discount;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}


	/**
	 * 小计每一条订单记录小计价格
	 * @return
	 */
	public double subTotalPrice(){
		double sub = this.price * this.discount * this.quantity / 10;
		DecimalFormat df = new DecimalFormat("0.00");
		return Double.parseDouble(df.format(sub));
		
	}
	/**
	 * 买价
	 * @return
	 */
	public double getBuyPrice(){
		double price = this.price * this.discount / 10;
		DecimalFormat df = new DecimalFormat("0.00");
		return Double.parseDouble(df.format(price));
		
	}
}
