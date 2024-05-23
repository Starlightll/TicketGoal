<%-- 
    Document   : AdminPanel
    Created on : May 23, 2024, 8:11:00 PM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div class="admin">
                <div class="admin__panel">
                    <div class="side__bar">
                        <p>Hi Admin</p>
                        <ul class="nav__list">
                            <li class="nav__item">
                                <a href="<c:url value='/matchServlet'/>" class="nav__link">MATCHES</a>
                            </li>
                            <li class="nav__item">
                                <a href="<c:url value='/playerServlet'/>" class="nav__link">PLAYER</a>
                            </li>
                            <li class="nav__item">
                                <a href="<c:url value='/shopServlet'/>" class="nav__link">SHOP</a>
                            </li>
                            <li class="nav__item">
                                <a href="<c:url value='/contactServlet'/>" class="nav__link">CONTACT</a>
                            </li>
                        </ul>
                    </div>
                    <div class="content__container">
                        <div class="content">
                            
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <div class="footer-container">
            <%@include file="/Views/include/footer.jsp" %>
        </div>
    </body>
</html>
