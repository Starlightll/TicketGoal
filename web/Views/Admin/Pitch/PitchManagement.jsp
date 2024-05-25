<%-- 
    Document   : PitchManagement
    Created on : May 25, 2024, 7:50:09 AM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/pitch/pitchmanagement.css"/>
    </head>
    <body>
        <div class="pitch__management__container">
            <div class="pitch__management__header">
                <form>
                    <input type="search">
                </form>
                <button onclick="location.href='${pageContext.request.contextPath}/pitchManagementServlet?option=add'" class="add__button">Add</button>
            </div>
            <div class="line__decor"></div>
            <div class="pitch__box">
                <div class="pitch">
                    <img src="${pageContext.request.contextPath}/img/pitch/pitch1.jpeg"/>
                     <div class="pitch__area">
                        <div class="area">
                            <div class="area__name">C1</div>
                            <p class="seats">2000</p>
                        </div>
                        <div class="area">
                            <div class="area__name">C1</div>
                            <p class="seats">2000</p>
                        </div>
                        <div class="area">
                            <div class="area__name">C1</div>
                            <p class="seats">2000</p>
                        </div>
                    </div>
                    <div class="pitch__manager__option">
                        <button class="update__button" onclick="location.href='${pageContext.request.contextPath}/pitchManagementServlet?option=update'">Update</button>
                        <button class="delete__button" onclick="location.href=''">Delete</button>
                    </div>
                    <div class="pitch__name">
                        <p>Pitch name</p>
                    </div>
                </div>
                    <div class="pitch">
                        <img src="${pageContext.request.contextPath}/img/pitch/pitch1.jpeg"/>
                        <div class="pitch__area">
                            <div class="area">
                                <div class="area__name">C1</div>
                                <p class="seats">2000</p>
                            </div>
                            <div class="area">
                                <div class="area__name">C1</div>
                                <p class="seats">2000</p>
                            </div>
                            <div class="area">
                                <div class="area__name">C1</div>
                                <p class="seats">2000</p>
                            </div>
                        </div>
                        <div class="pitch__manager__option">
                            <button class="update__button" onclick="location.href=''">Update</button>
                            <button class="delete__button" onclick="location.href=''">Delete</button>
                        </div>
                        <div class="pitch__name">
                            <p>Pitch name</p>
                        </div>
                    </div>
            </div>
        </div>
    </body>
</html>
