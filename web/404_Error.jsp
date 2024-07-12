<%-- 
    Document   : 404_Error
    Created on : May 18, 2024, 3:46:13 PM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
    <div style="text-align: center">
        <h1 style="font-size: 180px; align-content: center; text-align: center">404 Error</h1>
        <p>Sorry, the page you are looking for does not exist.</p>
        <a href="/homepageServlet">Go to Home Page</a>
    </div>
</main>
<div class="footer-container">
    <%@include file="/Views/include/footer.jsp" %>
</div>
</body>
</html>
