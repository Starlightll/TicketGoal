<%--
  Created by IntelliJ IDEA.
  User: mosdd
  Date: 7/27/2024
  Time: 6:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    <script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ticketchecking.css"/>
</head>
<body>
<div class="container">
    <div class="match__box">
        <div class="match">
            <div class="match__info">
                <h2>Match Info</h2>
                <p>Match Title: </p>
                <p>Match Date: ${match.date}</p>
                <p>Match Time: ${match.time}</p>
                <p>Match Location: ${match.location}</p>
                <p>Match Status: ${match.status}</p>
            </div>
            <div class="match__teams">
                <h2>Teams</h2>
                <p>${match.team1}</p>
                <p>${match.team2}</p>
            </div>
        </div>
    </div>

</div>
</body>
</html>

