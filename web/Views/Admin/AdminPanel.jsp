<%-- 
    Document   : AdminPanel
    Created on : May 23, 2024, 8:11:00 PM
    Author     : mosdd
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/adminpanel.css"/>
    </head>
    <body>
        <div class="header-container">
            <jsp:include page="../include/header.jsp"/>
        </div>
        <main>
            <div class="admin">
                <div class="side__bar">
                    <p>Hi Admin</p>
                    <div class="nav__list">
                        <div class="nav__item">
                            <a href="<c:url value='/homepageServlet'/>" class="nav__link">
                                <i class="ri-home-office-fill"></i>Home
                            </a>
                        </div>
                        <div class="nav__item">
                            <a class="nav__link dropdown__item">
                                <i class="ri-tools-fill"></i>Management
                                <i class="ri-arrow-drop-down-line"></i>
                            </a>
                            <div class="dropdown__menu">
                                <a href="<c:url value='/matchManagementServlet'/>" class="dropdown__link">
                                    Match management
                                </a>
                                <a href="<c:url value='/pitchManagementServlet'/>" class="dropdown__link">
                                    Pitch management
                                </a>
                                <a href="<c:url value='/homepageServlet'/>" class="dropdown__link">
                                    Seat management
                                </a>
                                <a href="<c:url value='/playerManagementServlet'/>" class="dropdown__link">
                                    Player management
                                </a>
                            </div>
                        </div>
                        <div class="nav__item">
                            <a href="<c:url value='/playerServlet'/>" class="nav__link">
                                <i class="ri-contacts-fill"></i>Contact</a>
                        </div>
                        <div class="nav__item">
                            <a href="<c:url value='/shopServlet'/>" class="nav__link">
                                <i class="ri-dashboard-fill"></i>Dashboard</a>
                        </div>
                    </div>
                </div>
                <div class="admin__content__container">
                        <jsp:include page="${page}"/>
                </div>
            </div>
        </main>
        <script src="${pageContext.request.contextPath}/js/admin/adminpanel.js"></script>
    </body>
</html>
