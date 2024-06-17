<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <style>
            main {
                margin: 20px;
            }
            h1 {
                color: #333;
            }
            input[type=password] {
                padding: 10px;
                margin: 10px 0;
                width: 200px;
            }
            button {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div>
                <div>
                    <h2>Hello ${email}</h2>
                </div>
                <form action="/changePasswordServlet" method="post">
                    <h1>Change your new password</h1>
                    <input type="password" name="newPassword" placeholder="Enter new password" required/>
                    <br>
                    <button type="submit">Submit</button>
                </form>
            </div>
        </main>
        <div class="footer-container">
            <%@include file="/Views/include/footer.jsp" %>
        </div>
    </body>
</html>
