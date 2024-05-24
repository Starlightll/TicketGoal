<%-- 
    Document   : MatchManagement
    Created on : May 24, 2024, 12:43:32 AM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/match/matchmanagement.css"/>
    </head>
    <body>
        <div class="match__management_container">
            <div class="match__header">
                <form>
                    <div class="search__box">
                        <input type="search">
                    </div>
                </form>
                <a class="add__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=add">Add</a>
            </div>
            <div class="line__decor"></div>
            <div class="match__list">
                <form>
                    <div class="match">
                        <div class="match__date">
                            <img src="./img/matches/DateBanner.png" alt="">
                            <div class="match__date__day">28</div>
                            <div class="match__date__month">Aug</div>
                        </div>
                        <div class="match__content">
                            <div class="club__section">
                                <div class="club">
                                    <img src="./img/clubLogos/AustriaVienna.png" alt="">
                                    <p>Club1</p>
                                </div>
                                <div class="vs"><p>VS</p></div>
                                <div class="club">
                                    <img src="./img/clubLogos/RedBullSalzburg.png" alt="">
                                    <p>Club2</p>
                                </div>
                            </div>
                            <div class="match__location">
                                <i class="ri-map-pin-2-fill"></i>
                                <p>SGF Stadium, London / 19:20</p>
                            </div>
                        </div>
                        <div class="option">
                            <a class="update__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=update">Update</a>
                            <a class="delete__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=delete">Delete</a>
                        </div>
                    </div>
                </form>
                <form>
                    <div class="match">
                        <div class="match__date">
                            <img src="./img/matches/DateBanner.png" alt="">
                            <div class="match__date__day">28</div>
                            <div class="match__date__month">Aug</div>
                        </div>
                        <div class="match__content">
                            <div class="club__section">
                                <div class="club">
                                    <img src="./img/clubLogos/AustriaVienna.png" alt="">
                                    <p>Club1</p>
                                </div>
                                <div class="vs"><p>VS</p></div>
                                <div class="club">
                                    <img src="./img/clubLogos/RedBullSalzburg.png" alt="">
                                    <p>Club2</p>
                                </div>
                            </div>
                            <div class="match__location">
                                <i class="ri-map-pin-2-fill"></i>
                                <p>SGF Stadium, London / 19:20</p>
                            </div>
                        </div>
                        <div class="option">
                            <a class="update__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=update">Update</a>
                            <a class="delete__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=delete">Delete</a>
                        </div>
                    </div>
                </form>
                <form>
                    <div class="match">
                        <div class="match__date">
                            <img src="./img/matches/DateBanner.png" alt="">
                            <div class="match__date__day">28</div>
                            <div class="match__date__month">Aug</div>
                        </div>
                        <div class="match__content">
                            <div class="club__section">
                                <div class="club">
                                    <img src="./img/clubLogos/AustriaVienna.png" alt="">
                                    <p>Club1</p>
                                </div>
                                <div class="vs"><p>VS</p></div>
                                <div class="club">
                                    <img src="./img/clubLogos/RedBullSalzburg.png" alt="">
                                    <p>Club2</p>
                                </div>
                            </div>
                            <div class="match__location">
                                <i class="ri-map-pin-2-fill"></i>
                                <p>SGF Stadium, London / 19:20</p>
                            </div>
                        </div>
                        <div class="option">
                            <a class="update__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=update">Update</a>
                            <a class="delete__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=delete">Delete</a>
                        </div>
                    </div>
                </form>
                <form>
                    <div class="match">
                        <div class="match__date">
                            <img src="./img/matches/DateBanner.png" alt="">
                            <div class="match__date__day">28</div>
                            <div class="match__date__month">Aug</div>
                        </div>
                        <div class="match__content">
                            <div class="club__section">
                                <div class="club">
                                    <img src="./img/clubLogos/AustriaVienna.png" alt="">
                                    <p>Club1</p>
                                </div>
                                <div class="vs"><p>VS</p></div>
                                <div class="club">
                                    <img src="./img/clubLogos/RedBullSalzburg.png" alt="">
                                    <p>Club2</p>
                                </div>
                            </div>
                            <div class="match__location">
                                <i class="ri-map-pin-2-fill"></i>
                                <p>SGF Stadium, London / 19:20</p>
                            </div>
                        </div>
                        <div class="option">
                            <a class="update__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=update">Update</a>
                            <a class="delete__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=delete">Delete</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
