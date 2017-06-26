package com.co.kr.vo;

public class BusStopWithBusBean {
	private String abpk;
	private String bsrpk;
	private String bsname;
	private String seq;
	private String updown;
	private String busid;
	public String getAbpk() {
		return abpk;
	}
	public void setAbpk(String abpk) {
		this.abpk = abpk;
	}
	public String getBsrpk() {
		return bsrpk;
	}
	public void setBsrpk(String bsrpk) {
		this.bsrpk = bsrpk;
	}
	public String getBsname() {
		return bsname;
	}
	public void setBsname(String bsname) {
		this.bsname = bsname;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getUpdown() {
		return updown;
	}
	public void setUpdown(String updown) {
		this.updown = updown;
	}
	public String getBusid() {
		return busid;
	}
	public void setBusid(String busid) {
		this.busid = busid;
	}
	@Override
	public String toString() {
		return "BusStopWithBusBean [abpk=" + abpk + ", bsrpk=" + bsrpk + ", bsname=" + bsname + ", seq=" + seq
				+ ", updown=" + updown + ", busid=" + busid + "]";
	}
}
