package com.co.kr.vo;

public class BusStopRoadViewBean {
	private String bsrpk;
	private String bsname;
	private String bslat;
	private String bslng;
	private String panoid;
	private String viewpoint;
	private String marker;
	private String mlat;
	private String mlng;
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
	public String getBslat() {
		return bslat;
	}
	public void setBslat(String bslat) {
		this.bslat = bslat;
	}
	public String getBslng() {
		return bslng;
	}
	public void setBslng(String bslng) {
		this.bslng = bslng;
	}
	public String getPanoid() {
		return panoid;
	}
	public void setPanoid(String panoid) {
		this.panoid = panoid;
	}
	public String getViewpoint() {
		return viewpoint;
	}
	public void setViewpoint(String viewpoint) {
		this.viewpoint = viewpoint;
	}
	public String getMarker() {
		return marker;
	}
	public void setMarker(String marker) {
		this.marker = marker;
	}
	public String getMlat() {
		return mlat;
	}
	public void setMlat(String mlat) {
		this.mlat = mlat;
	}
	public String getMlng() {
		return mlng;
	}
	public void setMlng(String mlng) {
		this.mlng = mlng;
	}
	@Override
	public String toString() {
		return "BusStopRoadViewBean [bsrpk=" + bsrpk + ", bsname=" + bsname + ", bslat=" + bslat + ", bslng=" + bslng
				+ ", panoid=" + panoid + ", viewpoint=" + viewpoint + ", marker=" + marker + ", mlat=" + mlat
				+ ", mlng=" + mlng + "]";
	}
	
}
