package com.co.kr.vo;

public class NewLocationBean {
	private String lpk;
	private String bpk;
	private String abpk;
	private String blat;
	private String blng;
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
		return "LocationBean [lpk=" + lpk + ", bpk=" + bpk + ", abpk=" + abpk + ", blat=" + blat + ", blng=" + blng
				+ ", time=" + time + ", isnew=" + isnew + "]";
	}
}
