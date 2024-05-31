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
                <%@include file="../Admin/AdminSidebar.jsp" %>
                <div class="admin__content__container">
                        <jsp:include page="${page}"/>
                </div>
            </div>
        </main>
        <script src="${pageContext.request.contextPath}/js/admin/adminpanel.js"></script>
    </body>
</html>
