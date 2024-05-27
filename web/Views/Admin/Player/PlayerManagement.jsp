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
                    <input type="text" name="search"/>
                </div>
                <div class="role">
                    <h1>Role name</h1>
                </div>
                <div class="card__box">
<<<<<<< HEAD

=======
>>>>>>> 5eafebbf9d183326c8afb8c2c1f827a73f78db13
                    <div>
                        <a href="<c:url value="/playerDetailServlet?playerId=1"/>" class="card-link">
                            <div class="card">
                                <div class="player__number">
                                    <p>99</p>
                                    <img src="./img/player/numberBanner.png"/>
                                </div>
                                <div class="card__content">
                                    <img src="./img/player/Cristiano_Ronaldo.jpg" alt="alt"/>
                                    <div class="player__name">
                                        <p>Player name</p>
                                    </div>
                                </div>
                            </div>
                        </a>    
                        <div class="card__management">
                            <button class="update__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=update'">Update</button>
                            <button class="delete__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=delete'">Delete</button>
                        </div>
                    </div>
                        
                        <div>
                        <a href="<c:url value="/playerDetailServlet?playerId=1"/>" class="card-link">
                            <div class="card">
                                <div class="player__number">
                                    <p>99</p>
                                    <img src="./img/player/numberBanner.png"/>
                                </div>
                                <div class="card__content">
                                    <img src="./img/player/Cristiano_Ronaldo.jpg" alt="alt"/>
                                    <div class="player__name">
                                        <p>Player name</p>
                                    </div>
                                </div>
                            </div>
                        </a>    
                        <div class="card__management">
                            <button class="update__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=update'">Update</button>
                            <button class="delete__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=delete'">Delete</button>
                        </div>
                    </div>
                        
                        <div>
                        <a href="<c:url value="/playerDetailServlet?playerId=1"/>" class="card-link">
                            <div class="card">
                                <div class="player__number">
                                    <p>99</p>
                                    <img src="./img/player/numberBanner.png"/>
                                </div>
                                <div class="card__content">
                                    <img src="./img/player/Cristiano_Ronaldo.jpg" alt="alt"/>
                                    <div class="player__name">
                                        <p>Player name</p>
                                    </div>
                                </div>
                            </div>
                        </a>    
                        <div class="card__management">
                            <button class="update__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=update'">Update</button>
                            <button class="delete__button" onclick="location.href = '${pageContext.request.contextPath}/playerManagementServlet?option=delete'">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
