package com.taobao.util;

import java.util.ArrayList;
import java.util.List;

public class Pager<T> {
	private int pageSize;
	private int pageIndex;
	private int totalRecords;
	private int totalPages;
	private List<T> list = new ArrayList<T>();
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getTotalRecords() {
		return totalRecords;
	}
	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages() {
		this.totalPages = this.totalRecords % this.pageSize == 0 ? this.totalRecords / this.pageSize : this.totalRecords / this.pageSize + 1;
	}
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}
	
	
	//是否在首页
	public boolean isFirst(){
		if(this.pageIndex == 1){
			return true;
		}else{
			return false;
		}
	}
	//是否在尾页
	public boolean isLast(){
		if(this.pageIndex >= this.totalPages){
			return true;
		}else{
			return false;
		}
	}
	//是否有上一页
	public boolean hasPrevious(){
		if(this.pageIndex > 1 && this.pageIndex <= this.totalPages){
			return true;
		}else{
			return false;
		}
	}
	//是否有下一页
	public boolean hasNext(){
		if(this.pageIndex < this.totalPages){
			return true;
		}else{
			return false;
		}
	}
	//首页
	public int firstPage(){
		return 1;
	}
	//尾页
	public int lastPage(){
		return this.totalPages;
	}
	//上一页
	public int previousPage(){
		if(this.hasPrevious()){
			return this.pageIndex - 1;
		}else{
			return 1;
		}
	}
	//下一页
	public int nextPage(){
		if(this.hasNext()){
			return this.pageIndex + 1;
		}else{
			return this.totalPages;
		}
	}
	
}
