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
                        <input type="search" placeholder="Search">
                    </div>
                </form>
                <button class="add__button" id="btn-add">Add</button>
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
        <!-- Add Match Form -->
        <form class="add__match" id="add-form">
            <div class="add__match__header">
                <h2>Add Match</h2>
                <i class="ri-close-large-fill" id="btn-close"></i>
            </div>
            <div class="match">
                <div class="match__content">
                    <div class="club__section">
                        <div class="club">
                            <img src="./img/clubLogos/AustriaVienna.png" alt="">
                            <h2>Name 1</h2>
                            <label>
                                <select name="club1">
                                    <option value="0">Select Club</option>
                                    <c:forEach var="club" items="${clubList}">
                                        <option value="${club.clubId}">${club.clubName}</option>
                                    </c:forEach>
                                </select>
                            </label>
                        </div>
                        <div class="vs"><p>VS</p></div>
                        <div class="club">
                            <img src="./img/clubLogos/AustriaVienna.png" alt="">
                            <h2>Name 1</h2>
                            <label>
                                <select name="club2">
                                    <option value="0">Select Club</option>
                                    <c:forEach var="club" items="${clubList}">
                                        <option value="${club.clubId}">${club.clubName}</option>
                                    </c:forEach>
                                </select>
                            </label>
                        </div>
                    </div>
                    <div class="match__time">
                        <label>
                            <input type="datetime-local" name="matchTime">
                        </label>
                    </div>
                </div>
                <div class="option">
                    <button class="add__button" type="submit">Add</button>
                </div>
            </div>
        </form>
    </body>
    <script src="${pageContext.request.contextPath}/js/admin/match/matchmanagement.js"></script>
</html>
