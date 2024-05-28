<%-- 
    Document   : PlayerManagement
    Created on : May 24, 2024, 7:25:46 PM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/player/playermanagement.css"/>
    </head>
    <body>
        <div class="player__management__container">
            <div class="add__button">
                <button onclick="location.href='${pageContext.request.contextPath}/playerManagementServlet?option=add'">Add</button>
            </div>
            <div class="player__box">
                <div class="search__box">
                    <form action="playerSearchServlet" method="post">
                        <div class="d-flex align-items-center position-relative mx-auto" style="max-width: 500px;">
                            <input name="search" class="form-control border-primary flex-grow-1 py-3 ps-4 pe-5" type="text" value="${txtS}" placeholder="Search...">
                            <button type="submit" class="btn btn-primary py-2 ms-2"><i class="fa fa-search"></i></button>
                        </div>
                    </form>
                </div>
                <div class="role">
                    <h1>Role name</h1>
                </div>
                <div class="card__box">
                    <c:forEach var="player" items="${listP}">

                    <div>
                        <a href="<c:url value="/playerDetailServlet?playerId=1"/>" class="card-link">
                            <div class="card">
                                <div class="player__number">
                                    <p>${player.playerNumber}</p>
                                    <img src="./img/player/numberBanner.png"/>
                                </div>
                                <div class="card__content">
                                    <img src="${player.image}" alt="alt"/>
                                    <div class="player__name">
                                        <p>${player.playerName}</p>
                                    </div>
                                </div>
                            </div>
                        </a>    
                        <div class="card__management">
                            <button class="update__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=update&idPlayer=${player.playerId}'">Update</button>
                            <button class="delete__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=delete&idPlayer=${player.playerId}'">Delete</button>
                        </div>
                    </div>
                        </c:forEach>
   
                </div>
            </div>
        </div>
    </body>
</html>
