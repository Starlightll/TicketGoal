<%-- 
    Document   : PlayerManagement
    Created on : May 24, 2024, 7:25:46 PM
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
        <form action="playerSearchByRoleNameServlet" method="post">
            <select name="playerRoleId">
                <option value="0">All</option>
                <option value="1">Goal keeper</option>
                <option value="2">Defender</option>
                <option value="3">Midfielder</option>
                <option value="4">Forward</option>
            </select>
            <input type="submit" value="Show">
        </form>
        <div class="search__box">
            <form method="post" action="playerSearchAdminServlet">
                <input type="text" name="search" placeholder="Search..."/>
                <button type="submit" value="Search">Search</button>
            </form>
        </div>
        <div class="role">
            <h1>Role name</h1>
        </div>
        <div class="card__box">
            <c:forEach var="player" items="${listP}">
                <div>
                    <a href="<c:url value="/playerManagementServlet?option=playerdetail&playerId=${player.playerId}"/>" class="card-link">
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
                        <button class="update__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=update&playerId=${player.playerId}'">Update</button>
                        <button class="delete__button" onclick="confirmDelete('${player.playerName}', '${pageContext.request.contextPath}/playerManagementServlet?option=delete&playerId=${player.playerId}')">Delete</button>
                    </div>
                </div>
            </c:forEach>  
        </div>
    </div>
</div>

<script>
    function confirmDelete(playerName, deleteURL) {
        if (confirm("Are you sure you want to delete player '" + playerName + "'?")) {
            window.location.href = deleteURL;
        }
    }
</script>
</body>
</html>
