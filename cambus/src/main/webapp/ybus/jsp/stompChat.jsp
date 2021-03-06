<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>

<script type="text/javascript" src="/cambus/ybus/js/jquery-1.11.3.min.js"></script>

<script type="text/javascript" src="/cambus/ybus/js/sockjs.js"></script>

<script type="text/javascript" src="/cambus/ybus/js/stomp.min.js"></script>



<script type="text/javascript">

    var socket = new SockJS('http://localhost:8080/cambus/stomp');

    var stompClient = Stomp.over(socket);

    stompClient.connect({}, function(frame) {

        $('#console').append('Connected: ' + frame + '<br>');

        stompClient.subscribe('/topic/stomp', function(message) {

            $('#console').append(message.body + '<br>');

        });

    });



    function disconnect() {

        if (stompClient != null) {

            stompClient.disconnect();

        }

        $('#console').append('Disconnected<br>');

    }

    

    function messageSend() {

        stompClient.send("/app/stomp", {}, $('#message').val());

    }

</script>

</head>

<body>



<input type="text" id="message" />

<input type="button" value="전송" onclick="messageSend();" />

<input type="button" value="종료" onclick="disconnect();" />

<div id="console" />



</body>

</html>