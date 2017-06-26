package com.co.kr.vo;

public class NoticeBean {
	private String npk;
	private String contents;
	private String registrant;
	private String link;
	private String seq;
	private String regdate;
	public String getNpk() {
		return npk;
	}
	public void setNpk(String npk) {
		this.npk = npk;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getRegistrant() {
		return registrant;
	}
	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "NoticeBean [npk=" + npk + ", contents=" + contents + ", registrant=" + registrant + ", link=" + link
				+ ", seq=" + seq + ", regdate=" + regdate + "]";
	}
	
	
}
