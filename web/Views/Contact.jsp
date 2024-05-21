<%-- 
    Document   : Contact
    Created on : May 21, 2024, 8:21:47 PM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">      
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css"/>
        <script src="./js/cont.js"></script>
    </head>
    <body>  
        <%@include file="/Views/include/header.jsp" %>
        <main>
            <!-- Responsive Contact Page with Dark Mode and Form Validation (vanilla JS).

*Designed & built for desktop and tablets with viewport width >= 720px and in landscape orientation.  -->

            <div class="contact-container">
                <div class="left-col">
                    <img class="logo" src="https://www.indonesia.travel/content/dam/indtravelrevamp/en/logo.png"/>
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

                    <form id="contact-form" method="post">
                        <label for="name">Full name</label>
                        <input type="text" id="name" name="name" placeholder="Your Full Name" required>
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" placeholder="Your Email Address" required>
                        <label for="message">Message</label>
                        <textarea rows="6" placeholder="Your Message" id="message" name="message" required></textarea>
                        <!--<a href="javascript:void(0)">--><button type="submit" id="submit" name="submit">Send</button><!--</a>-->

                    </form>
                    <div id="error"></div>
                    <div id="success-msg"></div>
                </div>
            </div>

            <!-- Image credit: Oliver Sjöström https://www.pexels.com/photo/body-of-water-near-green-mountain-931018/  -->
        </main>
    </body>
</html>