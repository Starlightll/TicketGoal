<%-- 
    Document   : PitchManagement
    Created on : May 25, 2024, 7:50:09 AM
    Author     : mosdd
--%>
<<<<<<< HEAD

=======
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
>>>>>>> 5eafebbf9d183326c8afb8c2c1f827a73f78db13
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
<<<<<<< HEAD
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
=======
                <button onclick="location.href = '${pageContext.request.contextPath}/pitchManagementServlet?option=add'" class="add__button">Add</button>
            </div>
            <div class="line__decor"></div>
            <div class="pitch__box">
                <c:forEach items="${requestScope.pitchList}" var="pitch">
                    <div class="pitch">
                        <img name="pitchImage" src="data:image/jpeg;base64,${pitch.image}"/>
>>>>>>> 5eafebbf9d183326c8afb8c2c1f827a73f78db13
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
<<<<<<< HEAD
                            <button class="update__button" onclick="location.href=''">Update</button>
                            <button class="delete__button" onclick="location.href=''">Delete</button>
                        </div>
                        <div class="pitch__name">
                            <p>Pitch name</p>
                        </div>
                    </div>
=======
                            <button class="update__button" onclick="location.href = '${pageContext.request.contextPath}/pitchManagementServlet?option=update&pitchId=${pitch.pitchId}'">Update</button>
                            <button class="delete__button" onclick="location.href = '${pageContext.request.contextPath}/pitchManagementServlet?option=delete&pitchId=${pitch.pitchId}'">Delete</button>
                        </div>
                        <div class="pitch__name">
                            <p><c:out value="${pitch.pitchName}"></c:out></p>
                        </div>
                    </div>
                </c:forEach>
>>>>>>> 5eafebbf9d183326c8afb8c2c1f827a73f78db13
            </div>
        </div>
    </body>
</html>
