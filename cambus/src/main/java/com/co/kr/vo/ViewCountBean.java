package com.co.kr.vo;

public class ViewCountBean {
	private String vpk;
	private String pagename;
	private String viewtime;
	private String count;
	public String getVpk() {
		return vpk;
	}
	public void setVpk(String vpk) {
		this.vpk = vpk;
	}
	public String getPagename() {
		return pagename;
	}
	public void setPagename(String pagename) {
		this.pagename = pagename;
	}
	public String getViewtime() {
		return viewtime;
	}
	public void setViewtime(String viewtime) {
		this.viewtime = viewtime;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return "ViewCountBean [vpk=" + vpk + ", pagename=" + pagename + ", viewtime=" + viewtime + ", count=" + count
				+ "]";
	}
	
	
}
