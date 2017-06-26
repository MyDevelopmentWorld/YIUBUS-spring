package com.co.kr.vo;

public class BusMapBean {
	private String lpk;
	private String bpk;
	private String abpk;
	private String blat;
	private String blng;
	private String busid;
	private String time;
	private String isnew;
	public String getLpk() {
		return lpk;
	}
	public void setLpk(String lpk) {
		this.lpk = lpk;
	}
	public String getBpk() {
		return bpk;
	}
	public void setBpk(String bpk) {
		this.bpk = bpk;
	}
	public String getAbpk() {
		return abpk;
	}
	public void setAbpk(String abpk) {
		this.abpk = abpk;
	}
	public String getBlat() {
		return blat;
	}
	public void setBlat(String blat) {
		this.blat = blat;
	}
	public String getBlng() {
		return blng;
	}
	public void setBlng(String blng) {
		this.blng = blng;
	}
	public String getBusid() {
		return busid;
	}
	public void setBusid(String busid) {
		this.busid = busid;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getIsnew() {
		return isnew;
	}
	public void setIsnew(String isnew) {
		this.isnew = isnew;
	}
	@Override
	public String toString() {
		return "BusMapBean [lpk=" + lpk + ", bpk=" + bpk + ", abpk=" + abpk + ", blat=" + blat + ", blng=" + blng
				+ ", busid=" + busid + ", time=" + time + ", isnew=" + isnew + "]";
	}
	
	
}
