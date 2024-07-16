<%-- 
    Document   : Homepage
    Created on : May 18, 2024, 3:55:33 PM
    Author     : mosdd
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TicketGoal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <link rel="icon" type="image/png" href="img/TicketGoalfavicon.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css"/>
</head>
<body>
<div class="header-container">
    <%@include file="/Views/include/header.jsp" %>
</div>
<main>
    <div class="hero__section">
        <div class="hero__title">
            <div class="title">
                <h1>Be part of the live action!</h1>
                <h2>Score tickets fast & safe on the most trusted platform</h2>
            </div>
            <button>Buy Ticket</button>
        </div>
        <div class="slider active">
            <img src="img/HomeHeroImage.png" alt="">
        </div>
        <div class="slider">
            <img src="img/HeroImage.png" alt="">
        </div>
        <div class="slider">
            <img src="img/HomeHeroImage.png" alt="">
        </div>
        <div class="slider">
            <img src="img/HeroImage.png" alt="">
        </div>
        <div class="navigation">
            <div class="btn active"></div>
            <div class="btn"></div>
            <div class="btn"></div>
            <div class="btn"></div>
        </div>
    </div>
    <div class="second__section">
        <h2 class="s2title">Most Popular Football Tickets</h2>
        <div class="popular__match__box">
            <div class="matches">
                <c:if test="${empty matches}">
                    <div class="empty__matches">
                        <p>There are no matches available at the moment</p>
                    </div>
                </c:if>
                <c:if test="${not empty matches}">
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
                                    <button class="buyTicket__btn" type="button" onclick="BuyTicket(${match.matchId})">
                                        Buy
                                        Ticket
                                    </button>
                                </div>
                            </div>
                        </form>
                    </c:forEach>
                </c:if>
            </div>
            <div class="feedbacks">

            </div>
        </div>
    </div>
</main>
<div class="footer-container">
    <%@include file="/Views/include/footer.jsp" %>
</div>
<script>
    const sliders = document.querySelectorAll('.slider');
    const btns = document.querySelectorAll('.btn');
    let currentSlide = 0;

    var manualNav = function (manual) {
        sliders.forEach((slider) => {
            slider.classList.remove('active');

            btns.forEach((btn) => {
                btn.classList.remove('active');
            });
        });

        sliders[manual].classList.add('active');
        btns[manual].classList.add('active');
    }

    btns.forEach((btn, i) => {
        btn.addEventListener('click', () => {
            manualNav(i);
            currentSlide = i;
        });
    });

    var repeat = function (activeClass) {
        let active = document.getElementsByClassName('active');
        let i = 1;
        var repeater = () => {

            setTimeout(function () {
                [...active].forEach((activeSlide) => {
                    activeSlide.classList.remove('active');
                });
                sliders[i].classList.add('active');
                btns[i].classList.add('active');
                i++;

                if (sliders.length === i) {
                    i = 0;
                }
                if (i >= sliders.length) {
                    return;
                }
                repeater();
            }, 5000);
        }
        repeater();
    }
    repeat();

</script>
</body>
</html>
