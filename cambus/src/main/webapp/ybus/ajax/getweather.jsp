<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String urlStr = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=4146152000"; 
 
URL url = new URL(urlStr);
 
URLConnection connection = url.openConnection();
 
connection.setDoOutput(true);
 
// 타입 설정
connection.setRequestProperty("CONTENT-TYPE","text/xml"); 
 
 
//openStream() : URL페이지 정보를 읽어온다.
BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(),"utf-8"));
    
String inputLine;
String buffer = "";

// 페이지의 정보를 저장한다.

 while ((inputLine = in.readLine()) != null){
	 //buffer +="<input type='text' value='"+inputLine.trim()+"'>";
	 buffer += inputLine.trim();
}
out.println(buffer);
in.close();
%>