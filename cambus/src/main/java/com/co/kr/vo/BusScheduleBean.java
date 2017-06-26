package com.co.kr.vo;

public class BusScheduleBean {
	private String bcpk;
	private String bcseq;
	private String bctime;
	private String bcline;
	private String bcperiod;
	private String currentBsc;
	public String getBcpk() {
		return bcpk;
	}
	public void setBcpk(String bcpk) {
		this.bcpk = bcpk;
	}
	public String getBcseq() {
		return bcseq;
	}
	public void setBcseq(String bcseq) {
		this.bcseq = bcseq;
	}
	public String getBctime() {
		return bctime;
	}
	public void setBctime(String bctime) {
		this.bctime = bctime;
	}
	public String getBcline() {
		return bcline;
	}
	public void setBcline(String bcline) {
		this.bcline = bcline;
	}
	public String getBcperiod() {
		return bcperiod;
	}
	public void setBcperiod(String bcperiod) {
		this.bcperiod = bcperiod;
	}
	public String getCurrentBsc() {
		return currentBsc;
	}
	public void setCurrentBsc(String currentBsc) {
		this.currentBsc = currentBsc;
	}
	@Override
	public String toString() {
		return "BusScheduleBean [bcpk=" + bcpk + ", bcseq=" + bcseq + ", bctime=" + bctime + ", bcline=" + bcline
				+ ", bcperiod=" + bcperiod + ", currentBsc=" + currentBsc + "]";
	}
	
}
