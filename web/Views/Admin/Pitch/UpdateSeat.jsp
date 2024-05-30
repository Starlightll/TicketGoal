<%-- 
    Document   : UpdatePitch
    Created on : May 25, 2024, 9:42:59 AM
    Author     : mosdd
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
            rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/pitch/updatepitch.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <div class="seat__add__box" id="seat-add-box" style="display: block;">
            <div class="form__container">
                <h2>Update Seat</h2>
                <form id="seat-add-form" action="seat?action=edit" method="POST">
                    <input type="hidden" name="seatId" value="${seatEdit.seatId}" />
                    <label for="seatNumber">Seat Number:</label>
                    <input type="number" id="seatNumber" name="seatNumber" required value="${seatEdit.seatNumber}">

                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" required value="${seatEdit.price}">

                    <label for="areaId">Area ID:</label>
                    <input type="number" id="areaId" name="areaId" required value="${seatEdit.areaId}">

                    <label for="seatStatusId">Seat Status ID:</label>
                    <input type="number" id="seatStatusId" name="seatStatusId" required value="${seatEdit.seatStatusId}">

                    <button type="submit">Save</button>
                    <a href="" type="button" id="seat-add-cancel-button">Back to pitch</a>
                </form>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/admin/pitch/updatepitch.js"></script>
    </body>
</html>
