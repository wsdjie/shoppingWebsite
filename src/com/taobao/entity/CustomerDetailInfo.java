package com.taobao.entity;

public class CustomerDetailInfo {
	private int customerId;
	private String name;
	private String telphone;
	private String movePhone;
	private String address;
	public CustomerDetailInfo() {
		super();
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelphone() {
		return telphone;
	}
	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}
	public String getMovePhone() {
		return movePhone;
	}
	public void setMovePhone(String movePhone) {
		this.movePhone = movePhone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
