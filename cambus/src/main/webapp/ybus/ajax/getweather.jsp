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
 
// Ÿ�� ����
connection.setRequestProperty("CONTENT-TYPE","text/xml"); 
 
 
//openStream() : URL������ ������ �о�´�.
BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(),"utf-8"));
    
String inputLine;
String buffer = "";

// �������� ������ �����Ѵ�.

 while ((inputLine = in.readLine()) != null){
	 //buffer +="<input type='text' value='"+inputLine.trim()+"'>";
	 buffer += inputLine.trim();
}
out.println(buffer);
in.close();
%>