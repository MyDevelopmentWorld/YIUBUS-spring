package com.co.kr.vo;

public class BusStopBean {
	private String abpk;
	private String bsname;
	private String ablat;
	private String ablng;
	private String line;
	private String seq;
	private String updown;
	public String getAbpk() {
		return abpk;
	}
	public void setAbpk(String abpk) {
		this.abpk = abpk;
	}
	public String getBsname() {
		return bsname;
	}
	public void setBsname(String bsname) {
		this.bsname = bsname;
	}
	public String getAblat() {
		return ablat;
	}
	public void setAblat(String ablat) {
		this.ablat = ablat;
	}
	public String getAblng() {
		return ablng;
	}
	public void setAblng(String ablng) {
		this.ablng = ablng;
	}
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
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
	@Override
	public String toString() {
		return "BusStopBean [abpk=" + abpk + ", bsname=" + bsname + ", ablat=" + ablat + ", ablng=" + ablng + ", line="
				+ line + ", seq=" + seq + ", updown=" + updown + "]";
	}
	
}
