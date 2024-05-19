<%-- 
    Document   : Player
    Created on : May 18, 2024, 6:17:23 PM
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
        <%@include file="/Views/include/header.jsp" %>
        <main>
            <h1>Here is Player page</h1>
            <div class="category__box">
                <form method="POST">
                    
                </form>
            </div>
            <div class="player__box">
                <div class="role">
                    <h1>Role name</h1>
                </div>
                <div class="card__box">
                    <div class="card">
                        <div class="player__number">
                            
                        </div>
                        <img src="src" alt=""/>
                        <div class="player__name"></div>
                    </div>
                </div>
            </div>
        </main>
        <%@include file="/Views/include/footer.jsp" %>
    </body>
</html>
