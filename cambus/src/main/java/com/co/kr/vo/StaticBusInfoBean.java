package com.co.kr.vo;

public class StaticBusInfoBean {
	private String bpk;
	private String url;
	private String term;
	public String getBpk() {
		return bpk;
	}
	public void setBpk(String bpk) {
		this.bpk = bpk;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	@Override
	public String toString() {
		return "StaticBusInfoBean [bpk=" + bpk + ", url=" + url + ", term=" + term + "]";
	}
	
}
