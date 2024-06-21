<%-- 
    Document   : Contact
    Created on : May 21, 2024, 8:21:47 PM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">      
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div class="contact-container">
                <div class="left-col">
                </div>
                <div class="right-col">
                    <div class="theme-switch-wrapper">
                        <label class="theme-switch" for="checkbox">
                            <input type="checkbox" id="checkbox" />
                        </label>
                        <div class="description">Dark Mode</div>
                    </div>

                    <h1>Contact us</h1>
                    <p>Planning to visit Indonesia soon? Get insider tips on where to go, things to do and find best deals for your next adventure.</p>
                    <form id="contact-form" method="post" action="contactServlet">
                        <label for="name">Full name</label>
                        <input type="text" id="name" name="name" placeholder="Your Full Name" required>
                        <label for="email">Email</label>
                        <input type="email" id="name" name="email" placeholder="Your Email" required>
                        <label for="title">Title</label>
                        <input type="text" id="title" name="title" placeholder="Your Title" required>
                        <label for="message">Message</label>
                        <textarea rows="6" placeholder="Your Message" id="message" name="message" required></textarea>
                        <button type="submit" id="submit" name="submit">Send</button>
                    </form>
                    <div id="error"></div>
                    <div id="success-msg"></div>
                </div>
            </div>
        </main>
        <script src="./js/cont.js"></script>
        <script type="text/javascript">
            function showToast(type, message) {
                toastr[type](message);
            }
            var message = '${requestScope.report}';
            if(message !== ''){
                showToast('success','Send Message Successfully!');
            }
        </script>
    </body>
</html>