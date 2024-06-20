<%-- 
    Document   : AdminSidebar
    Created on : May 29, 2024, 5:11:04 PM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/adminsidebar.css"/>
    </head>
    <body>
        <div class="admin__side__bar">
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
                    <div class="dropdown__menu" style="display: ${dropdownMenu}">
                        <a href="<c:url value='/matchManagementServlet'/>" ${matchManagementDropdown}class="dropdown__link">
                            Match management
                        </a>
                        <a href="<c:url value='/pitchManagementServlet'/>" ${pitchManagementDropdown} class="dropdown__link">
                            Pitch management
                        </a>
                        <a href="<c:url value='/playerManagementServlet'/>" ${playerManagementDropdown} class="dropdown__link">
                            Player management
                        </a>
                        <a href="<c:url value='/operatorManagementServlet'/>" ${operatorManagementDropdown} class="dropdown__link">
                            Operator management
                        </a>   
                        <a href="<c:url value='/promotionManagement'/>" ${promotionManagement} class="dropdown__link">
                            Promotion management
                        </a>   
                    </div>
                </div>
                <div class="nav__item">
                    <a href="<c:url value='/ContactAdminServlet'/>" class="nav__link">
                        <i class="ri-contacts-fill"></i>Contact</a>
                </div>
                <div class="nav__item">
                    <a href="<c:url value='/shopServlet'/>" class="nav__link">
                        <i class="ri-dashboard-fill"></i>Dashboard</a>
                </div>
            </div>
        </div>
        <script>
        </script>
    </body>
</html>
