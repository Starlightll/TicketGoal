<%-- 
    Document   : Matches
    Created on : May 18, 2024, 7:17:28 PM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
                    <c:forEach var="match" items="${matches}">
                    <form>
                        <div class="match">
                            <div class="match__date">
                                <img src="./img/matches/DateBanner.png" alt="">
                                <div class="match__date__day">${match.getDay()}</div>
                                <div class="match__date__month">${match.getMonth()}</div>
                            </div>
                            <div class="match__content">
                                <div class="club__section">
                                    <div class="club">
                                        <img src="data:image/jpeg;base64,${match.club1.clubLogo}" alt="">
                                        <p>${match.club1.clubName}</p>
                                    </div>
                                    <div class="vs"><p>VS</p></div>
                                    <div class="club">
                                        <img src="data:image/jpeg;base64,${match.club2.clubLogo}" alt="">
                                        <p>${match.club2.clubName}</p>
                                    </div>
                                </div>
                                <div class="match__location">
                                    <i class="ri-map-pin-2-fill"></i>
                                    <p>${match.address.getAddressName()} / ${match.getTime()}</p>
                                </div>
                            </div>
                            <div class="buy__ticket">
                                <button class="buyTicket__btn" type="button" onclick="BuyTicket(${match.matchId})">Buy Ticket</button>
                            </div>
                        </div>
                    </form>
                    </c:forEach>
                </div>
            </div>
        </main>
        <div class="footer-container">
            <%@include file="/Views/include/footer.jsp" %>
        </div>
        <script>
            function BuyTicket(matchId) {
                var matchIds = matchId;
                $.ajax({
                    url: `${pageContext.request.contextPath}/BuyTicket`,
                    method: "GET",
                    data: {
                        matchId: matchIds,
                    },
                    success: function (response) {
                        if(response === "loginRequired"){
                            const loginBox = document.getElementById('login');
                            loginBox.classList.add('show-login');
                        }else{
                            location.href = "BuyTicket?matchId=" + matchId;
                        }
                    },
                    error: function () {
                        alert("Error");
                    }
                });
            }
        </script>
    </body>
</html>
