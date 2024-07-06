<%-- 
    Document   : Homepage
    Created on : May 18, 2024, 3:55:33 PM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <main>
        <div class="hero__section">
            <img src="img/HomeHeroImage.png" alt="">
        </div>
        </main>
        <div class="footer-container">
        <%@include file="/Views/include/footer.jsp" %>
        </div>
    </body>
</html>
