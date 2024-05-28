<%-- 
    Document   : PitchManagement
    Created on : May 25, 2024, 7:50:09 AM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <div class="search-box">
                    <button class="btn-search"><i class="ri-search-line"></i></button>
                    <input type="text" class="input-search" placeholder="Type to Search...">
                </div>
                <button onclick="location.href = '${pageContext.request.contextPath}/pitchManagementServlet?option=add'" class="add__button">Add</button>
            </div>
            <div class="line__decor"></div>
            <div class="pitch__box">
                <c:forEach items="${requestScope.pitchList}" var="pitch">
                    <div class="pitch">
                        <img name="pitchImage" src="data:image/jpeg;base64,${pitch.image}"/>
                        <div class="pitch__manager__option">
                            <button class="update__button" onclick="location.href = '${pageContext.request.contextPath}/pitchManagementServlet?option=update&pitchId=${pitch.pitchId}'">Update</button>
                            <button class="delete__button" onclick="location.href = '${pageContext.request.contextPath}/pitchManagementServlet?option=delete&pitchId=${pitch.pitchId}'">Delete</button>
                        </div>
                        <div class="pitch__name">
                            <p><c:out value="${pitch.pitchName}"></c:out></p>
                            </div>
                        </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
