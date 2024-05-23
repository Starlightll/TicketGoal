<%-- 
    Document   : Matches
    Created on : May 18, 2024, 7:17:28 PM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
            rel="stylesheet"/>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/matches.css" />
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div class="matches">
                <form>
                    <div class="search__box">
                        <input type="search">
                    </div>
                </form>
                <div class="match__box">
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
                            <div class="buy__ticket">
                                <button type="submit" class="buyTicket__btn">Buy Ticket</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        <div class="footer-container">
            <%@include file="/Views/include/footer.jsp" %>
        </div>
    </body>
</html>
