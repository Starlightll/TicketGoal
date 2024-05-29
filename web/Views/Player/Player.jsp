
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="stylesheet" href="./css/player.css"/>
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div class="player">
                <div class="sidebar__box">    
                    <form method="POST">
                        <select name="role">
                            <option>Goalkeeper</option>
                            <option>Defender</option>
                        </select>
                    </form>
                </div>
                <div class="player__box">
                    <div class="search__box">
                        <form method="post" action="playerSearchServlet">
                            <input type="text" name="search" placeholder="Search..."/>
                            <button type="submit" value="Search">Search</button>
                        </form>
                    </div>
                    <div class="role">
                        <h1>Role name</h1>
                    </div>
                    <div class="card__box">
                        <c:forEach items="${requestScope.listP}" var="player">
                            <a href="<c:url value='/playerDetailServlet?playerId=${player.playerId}'/>" class="card-link">
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
                        </c:forEach>                       
                    </div>
                </div>
            </div>
        </main>
        <div class="footer-container">
            <%@include file="/Views/include/footer.jsp"%>
        </div>
    </body>
</html>
