<%-- 
    Document   : Homepage
    Created on : May 18, 2024, 3:55:33 PM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>TicketGoal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <link rel="icon" type="image/png" href="img/TicketGoalfavicon.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css"/>
</head>
<body>
<div class="header-container">
    <%@include file="/Views/include/header.jsp" %>
</div>
<main style="height: fit-content">
    <div class="hero__section">
        <div class="slider active">
            <button>Buy Ticket</button>
            <img src="img/HomeHeroImage.png" alt="">
        </div>
        <div class="slider">
            <button>Buy Ticket</button>
            <img src="img/HeroImage.png" alt="">
        </div>
        <div class="slider">
            <button>Buy Ticket</button>
            <img src="img/HomeHeroImage.png" alt="">
        </div>
        <div class="slider">
            <button>Buy Ticket</button>
            <img src="img/HeroImage.png" alt="">
        </div>
        <div class="navigation">
            <div class="btn active"></div>
            <div class="btn"></div>
            <div class="btn"></div>
            <div class="btn"></div>
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

                if(sliders.length === i) {
                    i = 0;
                }
                if(i >= sliders.length) {
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
