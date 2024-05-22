<%-- 
    Document   : Shop
    Created on : May 18, 2024, 8:41:33 PM
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
            <h1>Here is Shop page</h1>
        </main>
        <div class="footer-container">
        <%@include file="/Views/include/footer.jsp" %>
        </div>
    </body>
</html>
