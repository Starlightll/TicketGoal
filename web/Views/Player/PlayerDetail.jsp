<%-- 
    Document   : PlayerDetail
    Created on : May 21, 2024, 8:40:14 PM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
            rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/playerdetail.css"/>
</head>
<body>
<div class="header-container">
    <%@include file="/Views/include/header.jsp" %>
</div>
<main>
    <div class="player__detail">
        <button class="back__button" onclick="location.href = '<c:url value="/playerServlet"/>'">Back</button>
        <div class="player__box">
            <div class="player__img">
                <img name="playerImage" src="data:image/jpeg;base64,${Players.image}"/>
            </div>
            <div class="detail__box">
                <div class="info">
                    <h1 class="title">INFO</h1>
                    <div class="info__detail">
                        <div class="line__decor"></div>
                        <table border="0">
                            <tbody>
                            <tr>
                                <td class="label">Name:</td>
                                <td class="text">${Players.playerName}</td>
                            </tr>
                            <tr>
                                <td class="label">Role:</td>
                                <td class="text">${Players.roleName}</td>
                            </tr>
                            <tr>
                                <td class="label">Birth:</td>
                                <td class="text">${Players.dateOfBirth}</td>
                            </tr>
                            <tr>
                                <td class="label">Height:</td>
                                <td class="text">${Players.height} cm</td>
                            </tr>
                            <tr>
                                <td class="label">Weight:</td>
                                <td class="text">${Players.weight} kg</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="biography">
                    <h1 class="title">BIOGRAPHY</h1>
                    <div class="biograph__detail">
                        <div class="line__decor"></div>
                        <p>${Players.biography} </p>
                    </div>
                </div>
                <div class="skill">
                    <h1 class="title">SKILL</h1>
                    <div class="line__decor"></div>
                    <div class="skill__box">
                        <div class="skill__attribute">
                            <div class="skill__name">ATK:</div>
                            <div class="skill__bar">
                                <div class="skill__bar__fill" style="max-width: ${Players.ATK}%;"></div>
                            </div>
                        </div>
                        <div class="skill__attribute">
                            <div class="skill__name">DEF:</div>
                            <div class="skill__bar">
                                <div class="skill__bar__fill" style="max-width: ${Players.DEF}%;"></div>
                            </div>
                        </div>
                        <div class="skill__attribute">
                            <div class="skill__name">SPD:</div>
                            <div class="skill__bar">
                                <div class="skill__bar__fill" style="max-width: ${Players.SPD}%;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
