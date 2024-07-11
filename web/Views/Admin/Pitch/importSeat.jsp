<%-- 
    Document   : UpdatePitch
    Created on : May 25, 2024, 9:42:59 AM
    Author     : mosdd
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
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
        <h2>Import Seat</h2>
        <form id="seat-add-form" action="seat?action=import" method="POST" enctype="multipart/form-data">
            <input value="${areaId}" name="areaId" type="hidden"/>
            <input value="${pitchId}" name="pitchId" type="hidden"/>
            <input type="file" name="file" accept=".xlsx, .xls" required/>
            <button class="import__excel" type="submit">Import</button>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/admin/pitch/updatepitch.js"></script>
</body>
</html>
