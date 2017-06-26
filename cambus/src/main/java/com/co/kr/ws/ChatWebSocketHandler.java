package com.co.kr.ws;

import java.net.URLDecoder;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatWebSocketHandler extends TextWebSocketHandler {

 //private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	private Map<String, Map<String,Object>> users = new ConcurrentHashMap<String,Map<String,Object>>();
	
 @Override
 public void afterConnectionEstablished(WebSocketSession session) throws Exception {
  
	 
  String uri = session.getUri().toString();
  String data = URLDecoder.decode(uri,"UTF-8");
  data = data.substring(data.indexOf("=")+1);
  String []datas = data.split("_");
  Map<String,Object> datamap = new ConcurrentHashMap<String, Object>();
  datamap.put("session", session);
  datamap.put("dest", datas[0]);
  datamap.put("nickName", datas[1]);
  datamap.put("phoneNum", datas[2]);
  
  for(String s:datas){
	  log(s);
  }
  
  users.put(session.getId(), datamap);
  
  //초기 접속한유저의 session id를 해당 유저에게 알려주기위해
  TextMessage msg = new TextMessage("!"+session.getId());
  //느낌표는 ID를 보낸다는것을 뜻함
  session.sendMessage(msg);
  
  sendFirstInfo(session);
  
  //log(users.get(session.getId()).get(whatDest).getId()+"|||"+whatDest+"   님 접속"); 
  //처음 연결되고 users에 ID와 세션을 집어넣음
 }

 @Override
 public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
  log(session.getId() + " 연결 종료됨");
  String dest = users.get(session.getId()).get("dest").toString();
  users.remove(session.getId());
  sendLastInfo(dest);
  //사용자가 연결을 끊거나 혹은 끊기면 실행 -> users에 유저 제거
 }

 //클라이언트에서 보낸 메세지 수신
 @Override
 protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
  log(session.getId() + "로부터 메시지 수신: " + message.getPayload());
  sendSameDest(session,message);
 }
 
//같은 목적지 모든 유저에게 메세지 전송(채팅)
 private void sendSameDest(WebSocketSession session, TextMessage message) throws Exception  {
	 
	 String destAll="";
	 
	 String dest = users.get(session.getId()).get("dest").toString();
	 String nickName = users.get(session.getId()).get("nickName").toString();
	 
	 for (Map<String, Object> smap : users.values()) {
		 
		 WebSocketSession sock = (WebSocketSession)smap.get("session");
		 destAll = smap.get("dest").toString();
		 
		 //같은 목적지의 방인지 확인
		 if(destAll.equals(dest)){
			 
			 //자기가 자기한테 보냄
			 if(session.getId().equals(sock.getId()) ){
				 TextMessage newMessage = new TextMessage(message.getPayload()+"#fromMe#"+nickName);
				 log(newMessage.getPayload());
				 sock.sendMessage(newMessage);//websocket의 sendMessage함수
			 }else{//자기 외의 세션들
				 TextMessage newMessage = new TextMessage(message.getPayload()+"#fromOther#"+nickName);
				 log(newMessage.getPayload());
				 sock.sendMessage(newMessage);//websocket의 sendMessage함수
			 }
			 
		 }
		   
	 }
	 
}
 
 //접속시 자신과 같은목저지 사람들의 유저리스트 갱신
 private void sendFirstInfo(WebSocketSession session) throws Exception  {
	 
	 String destAll="";
	 String destAll2="";
	 String destForCount="";
	 String nickNameAll="";
	 String phoneNumAll="";
	 int count = 0;
	 
	 String dest = users.get(session.getId()).get("dest").toString();
	 
	 //같은방의 인원들의 수를 세기위함
	 for (Map<String, Object> smap : users.values()) {
		 destForCount = smap.get("dest").toString();
		 if(destForCount.equals(dest)){
			 count++;
		 }
	 }

	 for (Map<String, Object> smap : users.values()) {
		 
		 destAll = smap.get("dest").toString();
		 WebSocketSession sock = (WebSocketSession)smap.get("session");
		 
		 log(users.values().size()+""); 
		 
		 //같은 목적지의 방인지 확인
		 if(destAll.equals(dest)){
			 
			//클라이언트가 리스트를 한번 비우게 하고자보냄
			 TextMessage clearMessage = new TextMessage("clear");
			 sock.sendMessage(clearMessage);
			 
			 //목적지가 같은 전체만큼의 갯수대로 메세지 전달
			 for (Map<String, Object> ssmap : users.values()) {
				 
				 destAll2 = ssmap.get("dest").toString();

				 if(destAll2.equals(dest)){
					 WebSocketSession ssock = (WebSocketSession)ssmap.get("session");
					 nickNameAll = ssmap.get("nickName").toString();
					 phoneNumAll = ssmap.get("phoneNum").toString();
					 String from="";
					 
					 //자기가 자기한테 보냄
					 if(sock.getId().equals(ssock.getId()) ){
						 from = "fromMe";
						 
					 }else{//자기 외의 세션들
						 from = "fromOther";
						 
					 }
					 
					 TextMessage newMessage = new TextMessage("info#"+nickNameAll+"#"+phoneNumAll+"#"+from+"#"+count);
					 sock.sendMessage(newMessage);
				 }
				 
			 }
		 }
		   
	 }
	 
}
//소켓 종료시 자신과 같은목저지 사람들의 유저리스트 갱신
 private void sendLastInfo(String dest) throws Exception  {
	 
	 String destAll="";
	 String destAll2="";
	 String destForCount="";
	 String nickNameAll="";
	 String phoneNumAll="";
	 int count = 0;
	 
	 //같은방의 인원들의 수를 세기위함
	 for (Map<String, Object> smap : users.values()) {
		 destForCount = smap.get("dest").toString();
		 if(destForCount.equals(dest)){
			 count++;
		 }
	 }

	 for (Map<String, Object> smap : users.values()) {
		 
		 destAll = smap.get("dest").toString();
		 WebSocketSession sock = (WebSocketSession)smap.get("session");
		 
		 log(users.values().size()+""); 
		 
		 //같은 목적지의 방인지 확인
		 if(destAll.equals(dest)){
			 
			//클라이언트가 리스트를 한번 비우게 하고자보냄
			 TextMessage clearMessage = new TextMessage("clear");
			 sock.sendMessage(clearMessage);
			 
			 //목적지가 같은 전체만큼의 갯수대로 메세지 전달
			 for (Map<String, Object> ssmap : users.values()) {
				 
				 destAll2 = ssmap.get("dest").toString();

				 if(destAll2.equals(dest)){
					 WebSocketSession ssock = (WebSocketSession)ssmap.get("session");
					 nickNameAll = ssmap.get("nickName").toString();
					 phoneNumAll = ssmap.get("phoneNum").toString();
					 String from="";
					 
					 //자기가 자기한테 보냄
					 if(sock.getId().equals(ssock.getId()) ){
						 from = "fromMe";
						 
					 }else{//자기 외의 세션들
						 from = "fromOther";
						 
					 }
					 
					 TextMessage newMessage = new TextMessage("info#"+nickNameAll+"#"+phoneNumAll+"#"+from+"#"+count);
					 sock.sendMessage(newMessage);
				 }
				 
			 }
		 }
		   
	 }
	 
}


 @Override
 public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
  log(session.getId() + " 익셉션 발생: " + exception.getMessage());
 }

 private void log(String logmsg) {
  System.out.println(new Date() + " : " + logmsg);
 }

}