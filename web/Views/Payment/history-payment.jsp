<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History payment</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="stylesheet" href="./css/cart.css"/>
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div style="width: 100%; padding: 15px;">
                <h2>History payment</h2>
                <div class="cart-items" style="width: 100%; margin: 0; margin-top: 10px;">
                    <c:forEach var="ticket" items="${tickets}">
                        <div class="cart-item" style="position: relative; padding: 10px; border: 1px solid #ddd; margin-bottom: 10px;">
                            <!-- Label at the top right corner -->
                            <div class="label" style="position: absolute; top: 10px; right: 10px; background: #ff5733; color: white; padding: 5px; border-radius: 3px;">
                                ${ticket.status}
                            </div>
                            <div class="ticket-info">
                                <div class="image-placeholder">
                                    <div class="box-clubname">
                                        <p class="club1">${ticket.match.club1.clubName}</p>
                                        <p class="divider"></p>
                                        <p class="club2">${ticket.match.club2.clubName}</p>
                                    </div>
                                </div>
                                <div class="ticket-details">
                                    <p>Area: ${ticket.seat.area.areaName}</p>
                                    <p>Seat number: ${ticket.seat.seatNumber}</p>
                                    <p>Price: ${ticket.seat.price}</p>
                                    <p>Date: ${ticket.match.schedule}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                     <c:if test="${tickets.size() == 0}">
                        <div class="ticket-item">
                            No have ticket here
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </body>
</html>
